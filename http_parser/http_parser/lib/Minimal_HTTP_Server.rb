require 'socket'

class HTTPServer

    def initialize(port)
        @port = port
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
            request = RequestHandler.new.parse_request(data)
            #Sen kolla om resursen (filen finns)
            if File.exists?("./html/#{request[:resource]}")
                html = File.read("./html/#{request[:resource]}")
                status = 200
            else
                html = "<h1>404<h1>"
                status = 404
            end
            html = "<h1>Hello, World!</h1>"

            session.print "HTTP/1.1 200\r\n"
            session.print "Content-Type: text/html\r\n"
            session.print "Content-Type: text.css\r\n"
            session.print "\r\n"
            session.print html
            session.close
        end
    end
end

server = HTTPServer.new(4567)
server.start