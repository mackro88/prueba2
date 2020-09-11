require 'uri'
require 'net/http'
require 'openssl'
require 'json'

def request(address)
    url = URI(address)
    http = Net::HTTP.new(url.host, url.port)
    request = Net::HTTP::Get.new(url)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_PEER
    response = http.request(request)
    return JSON.parse(response.read_body)
end

curiosity = request('https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=0&api_key=LsR7M0qXQpiolnXxaLYGiKoAgR9ZghBKsrOAqVLn')
opportunity = request('https://api.nasa.gov/mars-photos/api/v1/rovers/opportunity/photos?sol=0&api_key=LsR7M0qXQpiolnXxaLYGiKoAgR9ZghBKsrOAqVLn')
spirit = request('https://api.nasa.gov/mars-photos/api/v1/rovers/spirit/photos?sol=0&api_key=LsR7M0qXQpiolnXxaLYGiKoAgR9ZghBKsrOAqVLn')

puts "curiosity"
curiosity["photos"].each do |fotos|
    puts fotos["camera"]
end
