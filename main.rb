require 'sinatra'
require 'haml'

get '/' do
  haml :index
end

get '/about' do
  'A little about me.'
end
