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

  get '/' do 
    erb :new  
  end 

 

  # get '/games/create_game' do 
  #   if !logged_in?
  #     redirect to '/login'
  #   end 
  #   erb :'/games/create_game'
  # end 
  
  # post '/games' do 
  #   @gamer = current_gamer
  #   if params[:name].empty?
  #       redirect to '/games/create_game'
  #   end
  #    @game = Game.create(name: params[:name], publisher: params[:publisher], rate: params[:rate])
  #   redirect to '/games'  
  # end 

  # get '/games' do 
  #   if logged_in?
  #     redirect to '/login'
  #   end 
  #   @gamer = current_gamer
  #   @games = @gamer.games 
  #   erb :"/games"
  # end 

 

end 

