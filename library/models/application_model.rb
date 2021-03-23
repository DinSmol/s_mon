require 'active_record'
class ApplicationModel < ActiveRecord::Base
  def self.sql_exec(sql)
    self.connection.execute(sql)
  end
end