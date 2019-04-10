class ListingsController < ApplicationController

    get '/listings' do
        @listings = Listing.all
        erb :'/listings/listings'
    end

    get '/create_listing' do
        erb :'listings/create_listing'
    end

    post '/create_listing' do
        @listing = Listing.create(address: params[:address], bedrooms: params[:bedrooms], bathrooms: params[:bathrooms], square_feet: params[:square_feet], price: params[:price])
        redirect to '/agent/show'
    end
end