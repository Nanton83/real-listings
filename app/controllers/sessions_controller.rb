class SessionsController < ApplicationController

    get '/signup' do
        if !logged_in?
        erb :'/agent/create_agent'
        else
            redirect to '/logout'
        end  
    end

    post '/signup' do
        if params[:email] == ""
            redirect to '/signup'
            elsif
            params[:user_name] == ""  #Making sure all the fields are filled out for signup
            redirect to '/signup'
            elsif
            params[:password] == ""
            redirect to '/signup'
        else
            @agent = Agent.create(email: params[:email], user_name: params[:user_name], password: params[:password])
            @agent.save
            session[:user_id] = @agent.id
            redirect to "/agents/#{current_agent.id}"
        end
    end

    get '/login' do
        if !logged_in?
        erb :'/agent/login'
        else
            redirect to "/agents/#{current_agent.id}"
        end
    end 

    post '/login' do
        @agent = Agent.find_by(user_name: params["user_name"])
        if @agent && @agent.authenticate(params[:password])  #confirms that user exists and password entered is correct
            session[:user_id] = @agent.id
            redirect to "/agents/#{current_agent.id}"
        else
            redirect to '/login'
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