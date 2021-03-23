require_relative '../../library/models/active_period'

class FillDb < ActiveRecord::Migration[6.1]
  def change
    data = []
    periods = []
    1000.times do |i|
      address = Array.new(4){rand(256)}.join('.')
      data.append({'address' => address, 'description' => "Object #{i}"})
      periods.append({'address' => address, 'started_at' => Time.now})
    end
    NetObject.insert_all(data)
    ActivePeriod.insert_all(periods)
  end
end
