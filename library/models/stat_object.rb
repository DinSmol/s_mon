require 'resolv'
require_relative 'application_model'

class StatObject < ApplicationModel
  self.table_name = 'stat_data'
end
