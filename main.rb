require 'sinatra'
require 'haml'

get '/' do
  haml :index
end

get '/skills' do
  haml :skills
end

get '/work' do
  haml :work
end

get '/contact' do
  haml :contact
end