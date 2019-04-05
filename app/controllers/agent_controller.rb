class AgentController < ApplicationController

    get '/signup' do
        # if !logged_in?
        erb :'/agent/create_agent'  
    end

    post '/signup' do
        if params[:email] == ""
            redirect to '/signup'
            elsif
            params[:user_name] == ""
            redirect to '/signup'
            elsif
            params[:password] == ""
            redirect to '/signup'
        else
        @signup_info = params
        erb :'/agent/agent_home'
        end
    end

end