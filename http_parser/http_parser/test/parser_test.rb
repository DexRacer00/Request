require_relative '../lib/request_handler.rb'

describe RequestHandler do

  before do
    @handler = RequestHandler.new
   
    @request = <<~END
    GET /grill HTTP/1.1
    User-Agent: Mozilla/4.0 (compatible; MSIE5.01; Windows NT)
    Host: www.tutorialspoint.com
    Accept-Language: en-us
    Accept-Encoding: gzip, deflate
    Connection: Keep-Alive
    END
  end

  describe "Parsing Simple HTTP GET Request" do
    
    it "extracts the HTTP verb" do
      result = @handler.parse_request(@request)
      _(result["verb"]).must_equal "GET"
    end

    it "extracts the HTTP resource" do
      result = @handler.parse_request(@request)
      _(result["resource"]).must_equal "/grill"
    end

    it "extracts the HTTP version" do
      result = @handler.parse_request(@request)
      _(result["version"]).must_equal "HTTP/1.1"
    end
  end

 
end