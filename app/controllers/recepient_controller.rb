require './config/environment'

class RecepientController < ApplicationController
    get '/recepients' do
        @recepients = Recepient.all

        #view
        erb :'recepients/index'
    end

    get '/recepients/new' do
        #view
        erb :'volunteers/new'
    end

    post '/recepients/new' do
        Volunteer.create(params)
        redirect '/volunteers'
    end

    get '/recepients/:id/edit' do
        @volunteer=Volunteer.find_by_id(params[:id])
        #view
        erb :'volunteers/edit'
    end

    patch '/recepients/:id' do
        volunteer = Volunteer.find_by_id(params[:id])
        volunteer.name = params[:name]
        volunteer.phone = params[:phone]
        volunteer.is_admin = params[:is_admin]
        volunteer.save
        #view
        redirect '/recepients'
    end

    delete '/recepients/:id' do
        Volunteer.delete(params[:id])
        redirect '/recepients'
    end
end