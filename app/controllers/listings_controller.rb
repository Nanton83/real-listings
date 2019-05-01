class ListingsController < ApplicationController
  

    get '/listings' do
        @listings = Listing.all    #Provides all listing information to be rendered in /listings/listings
        erb :'/listings/listings'
    end

    get '/listings/new' do
        redirect_if_not_logged_in
        erb :'listings/create_listing'    #renders page to create a new listing
    end

    post '/listings' do
        redirect_if_not_logged_in
        @listing = current_agent.listings.build(address: params[:address], bedrooms: params[:bedrooms], bathrooms: params[:bathrooms], square_feet: params[:square_feet], price: params[:price])
        if @listing.save                                    #if the listing can successfully be created and saved
          flash[:message] = "Successfully Created Listing"
          redirect to "/agents/#{@listing.agent_id}"          #renders the current agents show page through /agents/:id
        else
        redirect to '/listings/new'
        end
    end

    get '/listings/:id/edit' do
      redirect_if_not_logged_in #or if listings user != current user
      @listing = Listing.find_by(id: params[:id])
      redirect_if_not_listing_agent(@listing)
      erb :'/listings/edit_listing'
    end

    patch '/listings/:id' do
      redirect_if_not_logged_in
      @listing = Listing.find_by(id: params[:id])   #finds the current listing by using associated id
      if params[:address] && params[:bedrooms] && params[:bathrooms] && params[:square_feet] && params[:price] && @listing    #if all param fields are complete the edit will be processed 
          if current_agent == @listing.agent #refactor
            @listing.update(address: params[:address], bedrooms: params[:bedrooms], bathrooms: params[:bathrooms], square_feet: params[:square_feet], price: params[:price])
            redirect to "/agents/#{@listing.agent_id}"
          else
            flash[:message] = "Edit aborted.  This listing does not belong to you"  
            redirect to "/agents/#{current_agent.id}"
          end  
      else
        flash[:message] = "Edit aborted.  All fields must be complete."
        redirect to "/agents/#{current_agent.id}"
      end
    end

  delete '/listings/:id' do
    if logged_in?
      @listing = Listing.find_by_id(params[:id])
      
      @agent = Agent.find_by(id: @listing.agent_id)
      if current_agent == @agent  #refactor
        #delete action does not let a user delete a listing they did not create
        @listing.delete
      end
      redirect to "/agents/#{current_agent.id}"
    else
      redirect to '/login'
    end
  end


end