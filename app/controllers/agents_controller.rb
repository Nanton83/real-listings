class AgentsController < ApplicationController

    get '/signup' do
        # if !logged_in?
        erb :'/agent/create_agent'  
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
            session[:id] = @agent.id
            erb :'agent/show'
        end
    end

    get '/login' do
        #if !logged_in?
        erb :'/agent/login'
    end 

    post '/login' do
        @agent = Agent.find_by(:user_name => params[:username])
        binding.pry
        if @agent && @agent.authenticate(params[:password])

            session[:id] = @agent.id
            redirect to '/agent/show'
        else
            redirect to '/signup'
        end
    end

    get '/logout' do
        #if logged_in?
        session.destroy
        redirect to '/login'
    end

end