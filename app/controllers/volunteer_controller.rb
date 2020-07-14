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
        Volunteer.create(params)
        redirect '/volunteers'
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
end