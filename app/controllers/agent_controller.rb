class AgentController < ApplicationController

    get '/signup' do
        # if !logged_in?
        erb :'/agent/create_agent'  
    end

    post '/signup' do
        @signup_info = params
        erb :'/agent/agent_home'
    end

end