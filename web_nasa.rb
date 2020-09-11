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

fotos = request('https://api.nasa.gov/mars-photos/api/v1/rovers/photos?api_key=LsR7M0qXQpiolnXxaLYGiKoAgR9ZghBKsrOAqVLn')

