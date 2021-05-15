class HomeController < ApplicationController
  
  def index

    api_key = Rails.application.credentials.zoom[:api_key]  
    api_secret = Rails.application.credentials.zoom[:api_secret]
    
    payload = {
      iss: api_key,
      exp: 1.hour.from_now.to_i
    }

    token = JWT.encode(payload, api_secret, "HS256", { typ: 'JWT' })

    url = URI("https://api.zoom.us/v2/users?status=active&page_size=30&page_number=1")

    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true
    
    request = Net::HTTP::Get.new(url)
    request["authorization"] = "Bearer #{token}"
    request["content-type"] = 'application/json'

    response = https.request(request)
    puts "response.read_body"
    puts response.read_body
    
  end

  
  
end

