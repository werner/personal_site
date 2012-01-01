require 'sinatra'
require 'haml'
require 'barista'
require './lib/partials'

class Main < Sinatra::Base
  register Barista::Integration::Sinatra
  helpers Sinatra::Partials
  
  set :views, 'app/views'
  set :port, 58031
  
  get '/' do
    haml :index
  end
  
  post '/contact' do
    require 'pony'
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
end

Barista.compile_all!
Main.run!