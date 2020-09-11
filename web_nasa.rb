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
#curiosity["photos"].each do |item|
#    puts "<li><img src='"+item['img_src']+"'></li>" 
#end


def head
    '<!doctype html>
    <html lang="es">
      <head>
        <title>Muestra Api Nasa</title>
        <!-- Required meta tags -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
    
        <!-- CSS only -->
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
        <link rel="stylesheet" href="style.css">
      </head>
      <body style="background-color:black; color: white">'
end

def build_web_page(curiosity)
    lista = '
        <div class="content"> 
            <ul><h1>Curiosity</h1>
                <div class="row">
                    '
    curiosity["photos"].each do |item|
        img_link = item['img_src'] 
        lista += "<li><img src='#{img_link}'></li>"
        end 
    lista += '      </div>
                </ul>
            </div>'
    return lista
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

index = head() + build_web_page(curiosity) + foot()
File.write('./index.html', index)
