require 'sinatra'
require 'haml'
require 'barista'
require 'pony'
require 'sinatra/minify'
require 'sinatra/r18n'
require './lib/partials'
require 'debugger'

class Main < Sinatra::Base
  register Barista::Integration::Sinatra
  register Sinatra::Minify
  register Sinatra::R18n

  helpers Sinatra::Partials

  #Conf for r18n
  set :root, File.dirname(__FILE__)
  R18n.default_places { './config/locales' }
  
  before do
    session[:locale] = request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
  end

  #Conf for minify
  set :js_path, 'public/javascripts'
  set :js_url,  '/javascripts'
  
  set :css_path, 'public/stylesheets'
  set :css_url,  '/stylesheets'  

  #use the minify version in development too
  enable :force_minify
    
  #In order to set the views inside app
  set :views, 'app/views'

  get '/' do
    haml :index
  end
  
  post '/contact' do
    begin
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
     
      if params.empty?
        redirect '/'
        puts "params empty"
      else
        Pony.mail :to => 'werner_a_e@yahoo.es',
                  :from => params[:message][:mail],
                  :subject => 'Name: ' + params[:message][:name] + ', send it from the personal site ',
                  :body =>  params[:message][:body]
      end
    rescue Exception => e
      puts e.message
      puts e.backtrace.inspect
    end
  end

end

Main.run! :port => ARGV[0]
Barista.compile_all!
