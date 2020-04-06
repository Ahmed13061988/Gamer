class GamesController < ApplicationController 


    # def anything
    #     @games = Game.all 
    # end 

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

    get '/games/' do 
        if !logged_in?
            redirect to '/login'
        end 
        @gamer=current_gamer
        @games=current_gamer.games
        erb :"/games/games"
    end 

    
    get '/games' do 
        if !logged_in?
            redirect to '/login'
        end 
        @gamer=current_gamer
        @games=@gamer.games
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


     get "/games/" do 
        @game= Game.find(params[:id])
        erb :"/games/show"
     end 

    
    patch'/games/:id' do 
        if (params[:name]).empty? ||(params[:publisher]).empty?
            flash[:field_error] = "No change added, because you left the name empty!"
         redirect '/games'
        end 
      @game = Game.find(params[:id])
        @game.update(name: params[:name], publisher: params[:publisher], rate: params[:rate]) 
        @game.save
        redirect to "/games"
    end 

    delete '/games/:id.delete' do 
        if !logged_in?
            redirect to '/login'
        end 
        @game = Game.find(params[:id])
            @game.delete 
            redirect to '/games'
    end 
end 