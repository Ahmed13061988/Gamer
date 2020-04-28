class GamesController < ApplicationController 



    get '/games/create_game' do 
        if !logged_in?
            redirect to '/login'
        end 
        erb :'/games/create_game'
    end 

    post '/games' do 
        if params[:name].empty?
            redirect to '/games/create_game'
        end
         @game = Game.create(name: params[:name], publisher: params[:publisher], rate: params[:rate], :gamer_id => current_gamer.id)
        redirect to '/games'
    end 

    
    get '/games' do 
        if !logged_in?
            redirect to '/login'
        end 
        @games=current_gamer.games
        erb :"/games/games"
    end 

    get '/games/:id' do 
        if !logged_in?
            redirect to 'login'
        end 
        @game = Game.find(params[:id])
        erb :"games/show"
    end 

    get '/games/:id/edit' do 
        if !logged_in?
            redirect to 'login'
        end 
        @game = Game.find(params[:id])
        erb :"games/edit"
    end 

    
    patch'/games/:id' do 
        if (params[:name]).empty? ||(params[:publisher]).empty?
            flash[:field_error] = "No change, Please all fields are required! "
         redirect '/games'
        end 
      @game = Game.find(params[:id])
      if current_gamer.id != @game.gamer_id.to_i
        redirect '/games'
      else 
        @game.update(name: params[:name], publisher: params[:publisher], rate: params[:rate]) 
        #@game.save
        redirect to "/games"
     end 
    end 

    delete '/games/:id/delete' do 
        if !logged_in?
            redirect to '/login'
        end 
        @game = Game.find(params[:id])
        if current_gamer.id != @game.gamer_id.to_i
            redirect '/games'
          else 
            @game.delete 
            redirect to '/games'
      end 
    end 
end 