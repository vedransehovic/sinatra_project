require './config/environment'

class VolunteerController < ApplicationController
    get '/volunteers' do
        @volunteers = Volunteer.all

        #view
        erb :'volunteers/index'
    end

    get '/volunteers/new' do
        #view
        erb :'volunteers/new'
    end

    post '/volunteers/new' do
        volunteer = Volunteer.create(params)
        redirect '/volunteers'
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
            erb :'volunteers/login'
        end
    end

    get '/volunteers/:id/edit' do
        @volunteer=Volunteer.find_by_id(params[:id])
        #view
        erb :'volunteers/edit'
    end

    patch '/volunteers/:id' do
        volunteer = Volunteer.find_by_id(params[:id])
        volunteer.name = params[:name]
        volunteer.phone = params[:phone]
        volunteer.is_admin = params[:is_admin]
        volunteer.save
        #view
        redirect '/volunteers'
    end

    delete '/volunteers/:id' do
        Volunteer.delete(params[:id])
        redirect '/volunteers'
    end

    get '/volunteers/logout' do
        session.clear
        redirect '/deliveries'
    end
end