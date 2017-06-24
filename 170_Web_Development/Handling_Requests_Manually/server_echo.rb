require "socket"

server = TCPServer.new("localhost", 3003)
loop do
  # wait until request is made then accepts it and returns a client object
  client = server.accept

  # gets the first line of the request - the GET or POST and the path:port etc
  request_line = client.gets
  # then simply print it out to console
  puts request_line

  # Print out to client to see it in browser
  # - first line is so Chrome recognizes this as a well-formed response
  client.puts "HTTP/1.1 200 OK\r\n\r\n"
  client.puts request_line
  client.close
end
