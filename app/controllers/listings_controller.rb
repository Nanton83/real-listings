class ListingsController < ApplicationController
  

    get '/listings' do
        @listings = Listing.all    #Provides all listing information to be rendered in /listings/listings
        @agents = Agent.all       #Provides all agent information to be rendered in /listings/listings
        
        erb :'/listings/listings'
    end

    get '/listings/new' do
        erb :'listings/create_listing'    #renders page to create a new listing
    end

    post '/listings' do
        @listing = current_agent.listings.create(address: params[:address], bedrooms: params[:bedrooms], bathrooms: params[:bathrooms], square_feet: params[:square_feet], price: params[:price])
        if @listing.save                                    #if the listing can successfully be created and saved
        flash[:message] = "Successfully Created Listing"
        redirect to "/agents/#{@listing.agent_id}"          #renders the current agents show page through /agents/:id
        else
        redirect to '/listings/new'
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

    patch '/listings/:id' do
      
      if logged_in?
        @listing = Listing.find_by(id: params[:id])   #finds the current listing by using associated id
        if params[:address] && params[:bedrooms] && params[:bathrooms] && params[:square_feet] && params[:price]    #if all param fields are complete the edit will be processed 
        @listing.update(address: params[:address], bedrooms: params[:bedrooms], bathrooms: params[:bathrooms], square_feet: params[:square_feet], price: params[:price])
        redirect to "/agents/#{@listing.agent_id}"
      else
        flash[:message] = "Edit aborted.  All fields must be complete."
        redirect to "/agents/#{current_agent.id}"
      end
    else
      redirect to "/login"
    end
  end

  delete '/listings/:id' do
    if logged_in?
      @listing = Listing.find_by_id(params[:id])
      
      @agent = Agent.find_by(id: @listing.agent_id)
      if current_agent == @agent
        #delete action does not let a user delete a listing they did not create
        @listing.delete
      end
      redirect to "/agents/#{current_agent.id}"
    else
      redirect to '/login'
    end
  end


end