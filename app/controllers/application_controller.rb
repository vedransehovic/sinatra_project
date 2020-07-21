require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, 'X9mg3ZT1t1zpryljreR7uRcY3vgCjj2BKNO3bPBDJZrIMvKQ6fV2WmgpxY0OPH7H'
  end

  get "/" do
    redirect '/deliveries'
  end

  helpers do
    def current_user(session)
        Volunteer.find_by_id(session[:volunteer_id])
    end

    def is_logged_in?(session)
        !!session[:volunteer_id]
    end

    def is_admin?(session)
        volunteer = Volunteer.find_by_id(session[:volunteer_id])
        !!volunteer.is_admin
    end

  end

end
