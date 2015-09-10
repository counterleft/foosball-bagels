require 'net/http'
require 'uri'

def fetch(uri_str, limit = 10)
  exit(2) if limit == 0

  response = Net::HTTP.get_response(URI(uri_str))

  case response
  when Net::HTTPRedirection then
    location = response['location']
    fetch(location, limit - 1)
  else
    response
  end
end

response = fetch('https://bagel-central-lg.herokuapp.com')

unless response.is_a(Net::HTTPSuccess)
  puts "Did not receive HTTP 2xx from application health check. Got: #{response.code}"
  exit(1)
end
