require './lib/diagnostics'

module HttpHeaders

  def self.make(output, request)
    if request.verb == 'POST' && request.path == '/game'
      (redirect_header_top + header_bottom(output)).join("\r\n")
    else
      (standard_header_top + header_bottom(output)).join("\r\n")
    end
  end

  def self.redirect_header_top
    ["http/1.1 302 moved temporarily", "Location: http://127.0.0.1:9292/game"]
  end

  def self.standard_header_top
    ["http/1.1 200 ok"]
  end

  def self.header_bottom(output)
    ["date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
      "server: ruby",
      "content-type: text/html; charset=iso-8859-1",
      "content-length: #{output.length}\r\n\r\n"]
  end

end