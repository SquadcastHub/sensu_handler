#!/usr/bin/env ruby
require 'json'
require 'net/http'
require 'net/https'
require 'uri'


# For US Data Center
url_hook = "https://api.squadcast.com/v1/incidents/sensu/"+ARGV[0]

# For EU Data Center (Comment the above line and uncomment the below line)
# url_hook = "https://api.eu.squadcast.com/v1/incidents/sensu/"+ARGV[0]


event = JSON.parse(STDIN.read, :symbolize_names => true)

uri = URI(url_hook)
http = Net::HTTP.new(uri.host, uri.port)
http.read_timeout = 10
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_NONE
req = Net::HTTP::Post.new(uri.path, 'Content-Type' => 'application/json')
req.body = event.to_json
res = http.request(req)
puts "Data sent to Squadcast"
