require 'sinatra'
require 'haml'
require 'coffee-script'
require 'pony'
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

post '/contact' do
  Pony.options = {
    :via => :smtp,
    :via_options => {
      :address => 'smtp.sendgrid.net',
      :port => '587',
      :domain => 'heroku.com',
      :user_name => ENV['SENDGRID_USERNAME'],
      :password => ENV['SENDGRID_PASSWORD'],
      :authentication => :plain,
      :enable_starttls_auto => true
    }
  }
 
  Pony.mail :to => 'werner_a_e@yahoo.es',
            :from => params[:message][:mail],
            :subject => 'Name: ' + params[:message][:name] + ', send it from the personal site ',
            :body =>  params[:message][:body]
end
