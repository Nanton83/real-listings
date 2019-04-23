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

    get '/listings/:id/edit' do
      if logged_in?
        @listing = Listing.find_by(id: params[:id])
        erb :'/listings/edit_listing'
      else
        redirect to "/login"
      end
    end

    get '/listings/:id' do
      @listing = Listing.find_by(id: params[:id])
    end
    
    post '/listings/:id' do
      
    end

    patch '/listings/:id' do
      
      if logged_in?
        @listing = Listing.find_by(id: params[:id])
        binding.pry
        if params[:address] && params[:bedrooms] && params[:bathrooms] && params[:square_feet] && params[:price]
        @listing.update(address: params[:address], bedrooms: params[:bedrooms], bathrooms: params[:bathrooms], square_feet: params[:square_feet], price: params[:price])
        redirect to "/listings/#{@listing.agent_id}"
      else
        redirect to '/agents/show'
      end
    else
      redirect to "/login"
    end
  end


end