require './config/environment'
require 'chartkick'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, ENV['SESSION_SECRET']
  end

  get "/" do
    @total_runs = Delivery.total_deliveries
    @active_runs = Delivery.active_deliveries
    #view
    erb :'index'
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

    def not_logged_in? (error_message)
      unless is_logged_in?
        session[:error_message] = error_message
        redirect '/volunteers/login'
        #erb :"volunteers/login" - Tried this first but it didn't display the login form. rather it just displayed a message and continued executing the code. 
      end
    end

  end

end
