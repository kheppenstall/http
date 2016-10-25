class Shutdown

  attr_reader :requests

  def initialize(requests)
    @requests = requests
  end
  
  def output
    "Total Requests: #{requests + 1}"
  end

end