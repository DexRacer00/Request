require 'socket'
require_relative 'http_parser/lib/request_handler.rb'
class HTTPServer

    def initialize(port)
        @port = port
        @handler = RequestHandler.new
    end

    def start
        server = TCPServer.new(@port)
        puts "Listening on #{@port}"

        while session = server.accept
            data = ""
            while line = session.gets and line !~ /^\s*$/
                data += line
            end
            puts "RECEIVED REQUEST"
            puts "-" * 40
            puts data
            puts "-" * 40 

            #Er HTTP-PARSER tar emot "data"
            parsed_data = @handler.parse_request(data)
            resource = parsed_data["resource"]
            #Sen kolla om resursen (filen finns)

            file = "#{resource}"

            p file

            if File.exists?("./html#{file}")
                @status = '200'
                html = File.read("./html#{file}")              
           else
                @status = '404'
                html = "<h1>Not found</h1>"
           end

            session.print "HTTP/1.1 #{@status}\r\n"
            session.print "Content-Type: text/html\r\n"
            session.print "\r\n"
            session.print html
            session.close
        end
    end
end

server = HTTPServer.new(4567)
server.start
