require 'sinatra'
require 'sinatra/flash'
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

  #enable flash messages
  enable :sessions
  register Sinatra::Flash

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

  #In order to set the views inside app
  set :views, 'app/views'

  #use the minify version in development too
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

    validations = {:mail => t.val_email, :name => t.val_name, :body => t.val_msg}.map do |key, value|
                    value if params[key].empty?
                  end
   
    if validations.empty?
      Pony.mail :to => 'werner_a_e@yahoo.es',
                :from => params[:mail],
                :subject => 'Name: ' + params[:name] + ', send it from the personal site ',
                :body =>  params[:body]
    else
      flash[:warning] = validations
      redirect "/#contact"
    end
  end

end

Main.run! :port => ARGV[0]
Barista.compile_all!
