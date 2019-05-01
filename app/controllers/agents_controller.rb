class AgentsController < ApplicationController
    
    
  get '/agents/:id' do
    if logged_in?
    @listings = current_agent.listings
      erb :'agent/show'               #Provides the current agents listings to their show page
    else
    redirect to '/login'
    end
  end

    

end