require 'sinatra'
require 'net/http'

get '/' do
  "rubygems.org caching service"
end

get '/api/v1/dependencies' do
  puts "Looking up dependencies"
  uri = URI("http://rubygems.org/api/v1/dependencies?gems=#{params['gems']}")
  Net::HTTP.get(uri)
end

get '/gems/:gem' do
 get_gem params[:gem] unless File.exist? "gems/#{params[:gem]}"
 send_file "gems/#{params[:gem]}"
end

def get_gem(gem_name)
  puts "#{gem_name} does not exist locally, lets download it"
  
  puts `wget -P gems http://rubygems.org/gems/#{gem_name}`
  
end