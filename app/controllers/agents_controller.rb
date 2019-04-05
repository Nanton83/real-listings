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
            session[:user_id] = @agent.id
            erb :'agent/show'
        end
    end

end