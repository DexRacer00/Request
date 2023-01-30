require_relative("lib/minimal_server")

server = HTTPServer.new(4567)
server.start