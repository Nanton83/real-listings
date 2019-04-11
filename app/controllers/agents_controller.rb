class AgentsController < ApplicationController

    get '/signup' do
        # if !logged_in?
        erb :'/agent/create_agent'  
    end

    post '/signup' do
        if params[:email] == ""
            redirect to '/signup'
            elsif
            params[:user_name] == ""  #Making sure all the fields are filled out for signup
            redirect to '/signup'
            elsif
            params[:password] == ""
            redirect to '/signup'
        else
            @agent = Agent.create(email: params[:email], user_name: params[:user_name], password: params[:password])
            @agent.save
            session[:id] = @agent.id
            redirect to 'agent/show'
        end
    end

    get '/login' do
        #if !logged_in?
        erb :'/agent/login'
    end 

    post '/login' do
        @agent = Agent.find_by(user_name: params["user_name"])
        if @agent && @agent.authenticate(params[:password])  #confirms that user exists and password entered is correct
            session[:id] = @agent.id
            redirect to '/agent/show'
        else
            redirect to '/login'
        end
    end

    get '/logout' do
        #if logged_in?
        session.clear
        redirect to '/login'
    end

    get '/agent/show' do
        @agents = Agent.all
        @current_agent = Agent.find_by(session[:id])
        @listings = Listing.all
        erb :'/agent/show'
    end
    
    # get '/agent/:id' do
    #     @agent = Agent.find_by(session[:id])
    #     erb :'/agent/show'
    # end

    # get '/agent/:slug' do
    #     @agent = Agent.find_by_slug(params[:slug])
    #     @listings = @agent.listings
    #     erb :'/agent/show'
    #   end

end