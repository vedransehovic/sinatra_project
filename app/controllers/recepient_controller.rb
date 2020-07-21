require './config/environment'

class RecepientController < ApplicationController
    get '/recepients' do
        if is_logged_in?
            @recepients = Recepient.all
            #view
            erb :'recepients/index'
        else
            @error_message = "Please log in to see recepients"
            erb :"volunteers/login"
        end 
    end

    get '/recepients/new' do
        if is_logged_in?
        #view
        erb :'recepients/new'
        else
            @error_message = "Please log in to create a recepient!"
            erb :"volunteers/login"
        end 
    end

    post '/recepients' do
        if is_logged_in?
            Recepient.create(params)
            redirect '/recepients'
        else
            @error_message = "Please log in to create a recepient!"
            erb :"volunteers/login"
        end 
    end

    get '/recepients/:id/edit' do
        if is_logged_in?
            @recepient=Recepient.find_by_id(params[:id])
            #view
            erb :'recepients/edit'
        else
            @error_message = "Please log in to edit a recepient!"
            erb :"volunteers/login"
        end 
    end

    patch '/recepients/:id' do
        if is_logged_in?
            recepient = Recepient.find_by_id(params[:id])
            recepient.name = params[:name]
            recepient.address = params[:address]
            recepient.municipality = params[:municipality]
            recepient.phone = params[:phone]
            recepient.save
            #view
            redirect '/recepients'
        else
            @error_message = "Please log in to edit a recepient!"
            erb :"volunteers/login"
        end 
    end

    delete '/recepients/:id' do
        if is_logged_in? && is_admin?
            Recepient.delete(params[:id])
            redirect '/recepients'
        else
            @error_message = "Please log as an admin to delete a recepient!"
            erb :"volunteers/login"
        end 
    end
end