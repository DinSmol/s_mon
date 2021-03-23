require_relative '../models/net_object'
require_relative '../models/active_period'


class AddressesController < ApplicationController

  def get
    data = NetObject.where(disabled: false).to_a
  end

  def post body
    item = NetObject.new(body)
    active_period = ActivePeriod.create(address: body['address'])
    item.save
  end

  def put

  end

  def delete ip
    item = NetObject.find_by(address: ip)
    unless item.nil?
      active_period = ActivePeriod.find_by(address: ip, stopped_at: nil)
      active_period.stopped_at = Time.now
      active_period.save
      item.delete
    end
  end

end