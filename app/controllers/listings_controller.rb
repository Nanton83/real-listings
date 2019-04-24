class ListingsController < ApplicationController

    get '/listings' do
        @listings = Listing.all
        @agents = Agent.all
        
        erb :'/listings/listings'
    end

    get '/listings/new' do
        erb :'listings/create_listing'
    end

    post '/listings' do
        @listing = current_agent.listings.create(address: params[:address], bedrooms: params[:bedrooms], bathrooms: params[:bathrooms], square_feet: params[:square_feet], price: params[:price])
        if @listing.save
        flash[:message] = "Succesfsfully Created Listing"
        redirect to "/agents/#{@listing.agent_id}"
        else
        redirect to '/listings/new'
        end
    end

    # get '/listings/:id' do
    #   @listing = Listing.find_by(id: params[:id])

    # end

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
        @listing = Listing.find_by(id: params[:id])
        if params[:address] && params[:bedrooms] && params[:bathrooms] && params[:square_feet] && params[:price]
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
        #delete action logged in does not let a user delete a tweet they did not create
        @listing.delete
      end
      redirect to "/agents/#{current_agent.id}"
    else
      redirect to '/login'
    end
  end


end