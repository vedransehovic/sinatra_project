require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, ENV['SESSION_SECRET']
  end

  get "/" do
    redirect '/deliveries'
  end

  helpers do
    def current_user
        Volunteer.find_by_id(session[:volunteer_id])
    end

    def is_logged_in?
        !!session[:volunteer_id]
    end

    def is_admin?
        volunteer = Volunteer.find_by_id(session[:volunteer_id])
        !!volunteer.is_admin
    end

    def not_logged_in?
      unless logged_in?
        @error_message = "Please log in to make changes."
        erb :"volunteers/login"
      end
    end

  end

end
