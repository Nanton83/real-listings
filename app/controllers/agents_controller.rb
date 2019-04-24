class AgentsController < ApplicationController
    
    
  get '/agents/:id' do
    if logged_in?
    @listings = current_agent.listings
      erb :'agent/show'
    else
    redirect to '/login'
    end
  end

    

end