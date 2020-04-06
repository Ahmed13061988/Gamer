class GamerController < ApplicationController

   

    get '/singup' do 
        if logged_in? 
            redirect to '/profile'
        end 
    erb :'/gamers/create_gamer'
    end 



    post '/singup' do 
        if (params[:username]).empty? ||(params[:password]).empty?
            flash[:field_error] = "Please, enter your username and password "
            redirect to '/singup'
        end 
         @gamer = Gamer.create(username: params[:username], password: params[:password])
         session[:gamer_id] = @gamer.id 
         current_gamer = @gamer.id
          erb :'gamers/profile'
        end 


    get'/gamers/users' do 
        @gamer = Gamer.all
        erb :'/gamers/users'
    end 

        
    get "/gamers/:id/gamers/users" do 
        @gamer = Gamer.all
        erb :'/gamers/users' 
    end 


  

    
    get '/gamers/:id/games' do 
        if !logged_in?
            redirect 'login'
        end 
        @gamer = Gamer.find(params[:id])
        erb :'/gamers/othergamersgames'
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

    delete '/profile/:id' do #delete action
        @gamer = Gamer.find_by_id(params[:id])
        @gamer.delete
        redirect to '/'
    end



 end 