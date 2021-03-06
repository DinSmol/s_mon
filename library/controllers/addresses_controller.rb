require_relative '../models/net_object'
require_relative '../models/active_period'

# Class for operating address objects
class AddressesController < ApplicationController
  def get
    NetObject.where(id: @params['id']).to_a
  end

  def post
    item = NetObject.new(@params)
    item.save
  end

  def put
    item = NetObject.find_by(id: @params['id'])
    item ? NetObject.update(item.id, @params) : (raise 'Object is not exists')
  end

  def delete
    item = NetObject.find_by(id: @params['id'])
    item.delete unless item&.nil?
  end
end
