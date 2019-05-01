require './config/environment'
require 'rack-flash'
class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "my_application_secret"
    use Rack::Flash
  end

  get "/" do
    erb :welcome      #renders the welcome page
  end

  helpers do

    def logged_in?
      !!current_agent   #returns a boolean 
    end

    def current_agent
      @current_agent ||= Agent.find_by(:id => session[:user_id])    #Sets @current_agent to the active session
    end

    def redirect_if_not_logged_in
      if !logged_in?
        redirect to '/login'
      end
    end

    def redirect_if_not_listing_agent(listing)
      if listing.agent_id != current_agent.id
        flash[:message] = "You do not have access to that listings"
        redirect to "/agents/#{@listing.agent_id}"
      end
    end
    
  end
end
