require 'sinatra'
require 'haml'
require 'barista'
require 'pony'
require 'sinatra/minify'
require './lib/partials'

class Main < Sinatra::Base
  register Barista::Integration::Sinatra
  register Sinatra::Minify

  helpers Sinatra::Partials
  
  set :js_path, 'public/javascripts'
  set :js_url,  '/javascripts'
  
  set :css_path, 'public/stylesheets'
  set :css_url,  '/stylesheets'  
  
  set :views, 'app/views'
  
  enable :force_minify
   
  get '/' do
    haml :index
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

end

Main.run! :port => ARGV[0]
Barista.compile_all!