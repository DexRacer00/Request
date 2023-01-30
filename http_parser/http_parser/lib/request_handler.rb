class RequestHandler

  def parse_request(request)
    lines = request.split("\n")
    first_line = lines.first
    p (first_line)
    verb, resource, version = first_line.split(" ")
    {"verb" => verb, "resource" => resource, "version" => version}
    
  end

end