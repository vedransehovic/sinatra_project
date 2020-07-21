require './config/environment'

class VolunteerController < ApplicationController
    get '/volunteers' do
        if is_logged_in?(session) && is_admin?(session)
            @volunteers = Volunteer.all
            erb :'volunteers/index'
        else
            @error_message = "Please log in as an admin"
            erb :"volunteers/login"
        end        
    end

    get '/volunteers/new' do
        if is_logged_in?(session) && is_admin?(session)
            erb :'volunteers/new'
        else
            @error_message = "Please log in as an admin"
            erb :"volunteers/login"
        end  
    end

    post '/volunteers' do
        if is_logged_in?(session) && is_admin?(session)
            volunteer = Volunteer.create(params)
            redirect '/volunteers'
        else
            @error_message = "Please log in as an admin"
            erb :"volunteers/login"
        end  
    end

    get '/volunteers/login' do
        #view
        erb :'volunteers/login'
    end

    post '/volunteers/login' do
        volunteer = Volunteer.find_by(email: params[:email])
        if volunteer && volunteer.authenticate(params[:password])
            session[:volunteer_id] = volunteer.id
            redirect to '/deliveries'
        else
            @error_message = "Invalid email or password, please try again!"
            erb :'volunteers/login'
        end
    end

    get '/volunteers/:id/edit' do
        if is_logged_in?(session) && is_admin?(session)
            @volunteer=Volunteer.find_by_id(params[:id])
            #view
            erb :'volunteers/edit'        
        else
            @error_message = "Please log in as an admin"
            erb :"volunteers/login"
        end 
    end

    patch '/volunteers/:id' do
        if is_logged_in?(session) && is_admin?(session)
            volunteer = Volunteer.find_by_id(params[:id])
            volunteer.name = params[:name]
            volunteer.phone = params[:phone]
            volunteer.email = params[:email]
            volunteer.password = params[:password]
            volunteer.is_admin = params[:is_admin]
            volunteer.save
            #view
            redirect '/volunteers'
        else
            @error_message = "Please log in as an admin"
            erb :"volunteers/login"
        end 
    end

    delete '/volunteers/:id' do
        if is_logged_in?(session) && is_admin?(session)
            Volunteer.delete(params[:id])
            redirect '/volunteers'
        else
            @error_message = "Please log in as an admin"
            erb :"volunteers/login"
        end  
    end

    get '/volunteers/logout' do
        session.clear
        redirect '/deliveries'
    end
end