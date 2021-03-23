require "sinatra"
require 'active_record'
require './config/environments'
require_relative 'library/controllers/application_controller'
require_relative 'library/controllers/addresses_controller'
require_relative 'library/controllers/pinger_controller'
require_relative 'library/controllers/stat_controller'


ENV['RACK_ENV'] ||= 'development'

get "/addresses/:address" do
  result = AddressesController.new(params).get
  content_type :json, charset: 'utf-8'
  status 200
  result.to_json
end

post "/addresses" do
  result = AddressesController.new(params).post
  result ? (status 201) : (status 400)
  []
end

put "/addresses/:address" do
  result = AddressesController.new(params).put
  result ? (status 200) : (status 400)
  result
end

delete "/addresses/:address" do
  result = AddressesController.new(params).delete
  status 204
  []
end

# get "/pinger" do
#   result = PingerController.new().get
#   content_type :json, charset: 'utf-8'
#   status 200
#   result.to_json
# end

get "/stat" do
  result = StatController.new(self.params).get
  content_type :json, charset: 'utf-8'
  status 200
  result.to_json
end