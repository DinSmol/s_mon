require "thwait"
require 'net/ping'
require_relative '../models/net_object'
require_relative '../models/stat_object'
require_relative 'application_controller'


class PingerController < ApplicationController
  def get
    ips = NetObject.where(disabled: false).pluck(:address)

    threads = ips.map do |ip|
      Thread.new {
        begin
        Timeout::timeout(55) {
          Thread.abort_on_exception = true
          Thread.current[:ident] = ip
          Thread.current[:result] = `ping -q -c 1 -t 30 -w 60 #{ip}`  # | grep rtt`
        }
        rescue Timeout::Error
          Thread.exit
        end
      }
    end

    ThreadsWait.all_waits(*threads)
    buf = []
    threads.each do |thread|
      current_dt = Time.now
      if thread[:result].nil?
        loss, min, avg, max, mdev = 100, nil, nil, nil, nil
      else
        loss, min, avg, max, mdev = parse_data thread[:result]
      end
      buf.append({'address' => thread[:ident],
                  'min' => min,
                  'avg' => avg,
                  'max' => max,
                  'mdev' => mdev,
                  'loss' => loss,
                  'created_at' => current_dt})
    end
    StatObject.insert_all(buf)
  end

  def parse_data data
    matches = data.match /received, (.*)% packet loss.*\nrtt min\/avg\/max\/mdev = (.*)\/(.*)\/(.*)\/(.*) ms/m
    result = matches.captures.map(&:to_f) unless matches.nil?
  end
end