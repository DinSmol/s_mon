require_relative '../models/net_object'
require_relative '../models/active_period'


class AddressesController < ApplicationController

  def get
    NetObject.where(address: @params['address']).to_a
  end

  def post
    item = NetObject.new(@params)
    # active_period = ActivePeriod.create(address: body['address'])
    item.save
  end

  def put
    item = NetObject.find_by(address: @params['address'])
    item ? NetObject.update(item.id, @params) : (raise 'Object is not exists')
  end

  def delete
    item = NetObject.find_by(address: @params['address'])
    unless item.nil?
      # active_period = ActivePeriod.find_by(address: @params['address'], stopped_at: nil)
      # active_period.stopped_at = Time.now
      # active_period.save
      item.delete
    end
  end

end