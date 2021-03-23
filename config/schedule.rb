require 'active_record'
require_relative '../library/controllers/pinger_controller'


ActiveRecord::Base.establish_connection adapter: 'postgresql', database: 'servers', username: 'din', password: 'password', port: 5433
set :output, "/myapp/log/cron_log.log"
ENV.each { |k, v| env(k, v) }

every 2.minutes do
  rake "get_data"
end