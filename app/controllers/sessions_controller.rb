class SessionsController < ApplicationController
    
    get '/signup' do
        if !logged_in?
        erb :'/agent/create_agent'
        else
            redirect to '/logout'
        end  
    end

    #Looking for a more elegant way of confirming completed fields possibly by using validations
    post '/signup' do
        if  params[:email] == "" 
            flash[:message] = "Please Complete Form"
            redirect to '/signup'
            elsif params[:user_name] == ""  #Making sure all the fields are filled out for signup
            flash[:message] = "Please Complete Form"
            redirect to '/signup'
            elsif params[:password] == ""
            flash[:message] = "Please Complete Form"
            redirect to '/signup'
        else
            @agent = Agent.create(email: params[:email], user_name: params[:user_name], password: params[:password])
        
            if @agent.save                  #if the agent can successfully be created the session is set and redirected to show page
            session[:user_id] = @agent.id
            redirect to "/agents/#{current_agent.id}"      
            else
                flash[:message] = "Username Already Exists!"        #agent.create activates the validation set in the agent model
                redirect to '/signup'
            end
        end
    end

    get '/login' do
        if !logged_in?
        erb :'/agent/login'
        else
            redirect to "/agents/#{current_agent.id}"
        end
    end 

    post '/login' do
        @agent = Agent.find_by(user_name: params["user_name"])
        if @agent && @agent.authenticate(params[:password])  #confirms that user exists and password entered is correct
            session[:user_id] = @agent.id
            redirect to "/agents/#{current_agent.id}"
        else
            redirect to '/login'
        end
    end
    
    get '/logout' do
        if logged_in?
        session.clear               #clears session and redirects to welcome page
        redirect to '/'
        else
            redirect to '/'
        end
    end

end