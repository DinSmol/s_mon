require 'resolv'
require_relative 'application_model'

class NetObject < ApplicationModel
  self.table_name = 'objects'

  validates :address, presence: true, uniqueness: true, format: { with: Resolv::IPv4::Regex }
end
