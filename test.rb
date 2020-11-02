

require 'uri'
require 'net/http'
require 'openssl'

url = URI("https://wft-geo-db.p.rapidapi.com/v1/geo/countries")

http = Net::HTTP.new(url.host, url.port)
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_NONE

request = Net::HTTP::Get.new(url)
request["x-rapidapi-host"] = 'wft-geo-db.p.rapidapi.com'
request["x-rapidapi-key"] = '88ef9ab6b6mshee41aa0c6270592p18de4fjsnbd05d8468d31'

response = http.request(request)
puts response.read_body
