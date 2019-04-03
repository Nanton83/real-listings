class AgentController < ApplicationController

    get '/signup' do
        erb :'/agent/create_agent'
    end

end