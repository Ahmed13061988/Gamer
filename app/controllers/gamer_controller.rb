class GamerController < ApplicationController

    get '/signup' do   #reader
        if logged_in? 
            redirect to '/profile'
        end 
    erb :'/gamers/create_gamer'
    end 

    post '/signup' do   #writer 
        if (params[:username]).empty? ||(params[:password]).empty?
            flash[:field_error] = "Please, enter your username and password "
            redirect to '/signup'
        end 
         @gamer = Gamer.create(username: params[:username], password: params[:password])
         session[:gamer_id] = @gamer.id 
    
          erb :'gamers/profile'
        end 


    get '/gamers' do 
        @gamer = Gamer.all

        erb :'/gamers/gamers'
    end 

    get '/gamers/:id/games' do 
        if !logged_in?
            redirect 'login'
        end 
        @gamer = Gamer.find(params[:id])
        erb :'/gamers/view_games'
    end 

    
    get '/login' do 
        if logged_in? 
            redirect to '/profile'
        end 
        erb :'gamers/login'
    end 

    post '/login' do 
        @gamer= Gamer.find_by(username: params[:username])
        if @gamer && @gamer.authenticate(params[:password])
            session[:gamer_id]= @gamer.id 
            redirect '/profile'
        elsif (params[:username]).empty? || (params[:password]).empty?
            flash[:field_error]= "You must enter your username and password"
            redirect '/login'
        else 
            flash[:field_error]="The Username or Password not correct"
            redirect 'login'
        end 
    end 

    get '/profile' do 
        if logged_in?
            @gamer = current_gamer
            erb :'gamers/profile'
        end 
    end 

    get '/logout' do 
        if logged_in?
            session.clear
            redirect to '/'
        else 
            redirect to '/'          
        end
    end 

    delete '/gamers/:id/delete' do #delete action
         @gamer = Gamer.find_by_id(params[:id])
        session.clear 
        @gamer.delete
        redirect to '/'
    end




 end 