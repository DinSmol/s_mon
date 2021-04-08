# Base abstract class
class ApplicationController
  def initialize(params = nil)
    @params = params
  end
end
