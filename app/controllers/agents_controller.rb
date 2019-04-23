class AgentsController < ApplicationController
    
    
    get '/agent/show' do
        @agent = current_agent
        redirect to "/agents/#{@agent.id}"
    end

    get '/agents/:id' do
        if logged_in?
          @listings = current_agent.listings
          erb :'agent/show'
        else
          redirect to '/login'
        end
    end

    

end