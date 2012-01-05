require 'sinatra'
require 'haml'
require 'barista'
require 'pony'
require 'sinatra/minify'
require 'sinatra/i18n'
require './lib/partials'

class Main < Sinatra::Base
  register Barista::Integration::Sinatra
  register Sinatra::Minify
  register Sinatra::I18n

  helpers Sinatra::Partials
  
  #Conf for i18n
  root = File.dirname(__FILE__)
  set :locales, %w[File.join(root, 'config/en.yml') File.join(root, 'config/es.yml')]
  set :default_locale, 'es'
  set :locale_pattern, /^\/?(#{Regexp.union(settings.locales)})(\/.+)$/
  
  helpers do
    def locale
      @locale || settings.default_locale
    end
  end  
  
  before do
    @locale, request.path_info = $1, $2 if request.path_info =~ settings.locale_pattern
  end  
  
  #Conf for minify
  set :js_path, 'public/javascripts'
  set :js_url,  '/javascripts'
  
  set :css_path, 'public/stylesheets'
  set :css_url,  '/stylesheets'  

  enable :force_minify
    
  #In order to set the views inside app
  set :views, 'app/views'
     
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