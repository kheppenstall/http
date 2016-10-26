class HelloWorld

  attr_reader :requests

  def initialize(requests)
    @requests = requests
  end

  def output
    "Hello, World! (#{requests})"
  end

end