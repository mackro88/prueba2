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

#puts "curiosity"
#curiosity["photos"].each do |fotos|
#puts fotos["camera"]
#end

def head
    '<!doctype html>
    <html lang="es">
      <head>
        <title>Muestra Api Nasa</title>
        <!-- Required meta tags -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
    
        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
      </head>'
end

def body()
 
end

def foot
    '<!-- Optional JavaScript -->
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
  </body>
</html>'
end

index = head() + foot()
File.write('./index.html', index)