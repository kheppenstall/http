class HelloWorld

  attr_reader :requests

  def initialize(requests)
    @requests = requests
  end

  def output
    "Hello, world (#{requests})"
  end

end