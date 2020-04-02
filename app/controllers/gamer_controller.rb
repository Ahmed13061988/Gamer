class GamerController < ApplicationController

    get '/singup' do 
        if logged_in? 
            redirect to '/profile'
        end 
    erb :'/gamers/create_gamer'
    end 

    def gamer 
        @gamer = Gamer.all 
    end 
    

    post '/singup' do 
        if (params[:username]).empty? ||(params[:password]).empty?
            flash[:field_error] = "Please, enter your username and password "
            redirect to '/singup'
        end 
         @gamer = Gamer.create(username: params[:username], password: params[:password])
         @gamer.save
         session[:gamer_id] = @gamer.id 
          erb :'gamers/profile'
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
        end 
    end 

    get '/profile' do 
        if logged_in?
            @gamer= current_gamer
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

 end 