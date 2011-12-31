require 'sinatra'
require 'haml'
require 'coffee-script'
require './lib/partials'

helpers Sinatra::Partials

get '/' do
  haml :index
end

get '/app.js' do
  coffee :app
end

get '/links.js' do
  coffee :links
end