require "socket"

def parse_request(request_line)
  http_method, path_and_params, http = request_line.split(" ")
  path, params = path_and_params.split("?")

  params = params.split("&").each_with_object({}) do |pair, hash|
    key, value = pair.split("=")
    hash[key] = value
  end

  [http_method, path, params]
end

server = TCPServer.new("localhost", 3003)
loop do
  # wait until request is made then accepts it and returns a client object
  client = server.accept

  # gets the first line of the request - the GET or POST and the path:port etc
  request_line = client.gets

  # ignores the additional request by the browser for a "favicon.ico"
  # this may cause program to crash
  next if !request_line || request_line =~ /favicon/
  # then simply print it out to console
  http_method, path, params = parse_request(request_line)
  puts request_line


  # Print out to client to see it in browser
  # - first line is so Chrome recognizes this as a well-formed response
  client.puts "HTTP/1.1 200 OK\r\n\r\n"
  client.puts request_line
  client.puts http_method
  client.puts path
  client.puts params

  rolls = params["rolls"].to_i
  sides = params["sides"].to_i

  rolls.times do
    roll = rand(sides) + 1
    client.puts roll
  end

  client.close
end
