class AgentController < ApplicationController

    get '/signup' do
        # if !logged_in?
        erb :'/agent/create_agent'  
    end

end