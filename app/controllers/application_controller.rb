require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "my_application_secret"
  end

  get "/" do
    erb :welcome
  end

  helpers do
    def logged_in?
      !!current_agent
    end

    def current_agent
      @current_agent ||= Agent.find_by(session[:user_id]) if session[:user_id]
    end

  end

end
