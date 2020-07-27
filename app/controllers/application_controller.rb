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
    @municipalities = Delivery.by_municipality
    @dates = Delivery.by_date
    #view
    erb :'deliveries/charts'
    #redirect '/deliveries'
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
        #erb :"volunteers/login"
      end
    end

  end

end
