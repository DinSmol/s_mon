require './servers_app'
require 'sinatra'
require 'active_record'
require 'sinatra/activerecord'
require 'sinatra/activerecord/rake'


desc 'Start pinger!'
task :get_data do
  PingerController.new().get
end
