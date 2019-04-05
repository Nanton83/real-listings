class ListingsController < ApplicationController

    get '/listings' do
        erb :'listings/listings'
    end
end