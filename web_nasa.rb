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

user_key = 'LsR7M0qXQpiolnXxaLYGiKoAgR9ZghBKsrOAqVLn'
curiosity = request("https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=0&api_key=#{user_key}")
opportunity = request("https://api.nasa.gov/mars-photos/api/v1/rovers/opportunity/photos?sol=1&api_key=#{user_key}")
spirit = request("https://api.nasa.gov/mars-photos/api/v1/rovers/spirit/photos?sol=2&api_key=#{user_key}")

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
        <style type="text/css"> ul {list-style-type: none;} </style>"
      </head>
      <body style="background-color:black; color: white">'
end

def build_web_page(curiosity, opportunity, spirit)
    lista = '
     <div class="content"> 
      <ul><h1>Curiosity</h1>
       <div class="row">
        '
    curiosity["photos"].each do |item_c|
        img_link_c = item_c['img_src'] 
        lista += "\t<li class='col-2 pt-2'><img src='#{img_link_c}' width=200px></li>\n"
        end 
    lista += ' </div>
        </ul>
        <ul><h1>Opportunity</h1>
       <div class="row">
        '
    opportunity["photos"].each do |item_o|
        img_link_o = item_o['img_src'] 
        lista += "\t<li class='col-2 pt-2'><img src='#{img_link_o}' width=200px></li>\n"
        end 
    lista += ' </div>
        </ul>
        <ul><h1>Spirit</h1>
       <div class="row">
        '
    spirit["photos"].each do |item_s|
        img_link_s = item_s['img_src'] 
        lista += "\t<li class='col-2 pt-2'><img src='#{img_link_s}' width=200px></li>\n"
        end 
    lista += ' </div>
        </ul>
    </div>
            '
    return lista
end

def foot
    '<!-- JS, Popper.js, and jQuery -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js" integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8shuf57BaghqFfPlYxofvL8/KUEfYiJOMMV+rV" crossorigin="anonymous"></script>
  </body>
</html>'
end

index = head() + build_web_page(curiosity, opportunity, spirit) + foot()
File.write('./index.html', index)


#def photos_count(curiosity)
#    n_photos = 0
#    print "La cámara  tomó #{n_photos}"
#    hash_camara = {}
 #   curiosity["photos"].each do |item_c|        
#        n_photos = item_c["camera"].count

#       hash_camara = nombre["camera"].select{|x,v| x==}
#    end
#    print hash_camara

#end

#photos_count(curiosity)