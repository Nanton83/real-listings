class ListingsController < ApplicationController

    get '/listings' do
        @listings = Listing.all
        @agents = Agent.all
        
        erb :'/listings/listings'
    end

    get '/create_listing' do
        erb :'listings/create_listing'
    end

    post '/create_listing' do
        @listing = current_agent.listings.create(address: params[:address], bedrooms: params[:bedrooms], bathrooms: params[:bathrooms], square_feet: params[:square_feet], price: params[:price])
        if @listing.save
        redirect to "/agents/#{@listing.agent_id}"
        else
        redirect to '/create_listing'
        end
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