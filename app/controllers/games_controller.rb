class GamesController < ApplicationController 


    def anything
        @games = Game.all 
    end 

    get '/games' do 
        if !logged_in?
            redirect to '/login'
        end 
       
        @games = current_gamer.games 
      
        erb :"/games/games"
    end 

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
         @game = Game.create(name: params[:name], publisher: params[:publisher], rate: params[:rate])
        redirect to '/games'
    end 

    get '/games/:id/edit' do 
        if !logged_in?
            redirect to 'login'
        end 
        @game = Game.find(params[:id])
        if current_gamer.id !=@game.gamer_id 
            redirect to '/games'
        end 
        erb :"games/edit/game"
    end 
    
    patch '/games/:id' do 
        game = Game.find(params[:id])
        if params[:name].empty?
            redirect to '/games/#{params[:id]}/edit'
        end 
        game.update(name: params[:name], publisher: params[:publisher], rate: params[:rate])
        game.save

        redirect to "/games/#{game.id}"
    end 

    delete '/games/:id/delete' do 
        if !logged_in?
            redirect to '/login'
        end 
        @game = Game.find(params[:id])
        if current_gamer.id != @game.gamer_id
            redirect to '/games'
        else 
            @game.delete 
            redirect to '/games'
        end 
    end 
end 