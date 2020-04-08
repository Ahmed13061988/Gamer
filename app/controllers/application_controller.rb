require './config/environment'
require 'rack-flash'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions 
    set :session_secret, "secret"
    use Rack::Flash 

  end

  helpers do 
    def current_gamer
     @gamer ||= Gamer.find(session[:gamer_id])
     end 
   end 


   def logged_in? 
    !!session[:gamer_id]
   end

  get '/' do  #This path will open the new page for us (Sign up or login page )
    erb :new  
  end 

end 

