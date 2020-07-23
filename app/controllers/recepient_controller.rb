require './config/environment'

class RecepientController < ApplicationController
    get '/recepients' do
     #if query @recipients = Recipient.search(query)
        if is_logged_in?
            if params[:lookup] #checking if recepient query exists (on delivery creation)
                @recepients = Recepient.search(params[:lookup])
            else 
                @recepients = Recepient.all
            end
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

    post '/recepients/new' do #NEED HELP REFACTORING
        if is_logged_in?
            if params[:new_delivery_recepient] #checking if creation is initiated from new delivery form and if it is delete that paramter, assign it to a variable and proceed
                @new_delivery=params.delete(:new_delivery_recepient)
            end 
            @recepient = Recepient.new(params)
            if @recepient.save
                if @new_delivery
                    redirect "recepients/#{@recepient.id}/deliveries/new"
                else
                    redirect '/recepients'
                end
            else 
                @error = (@recepient.errors.full_messages)
                erb :'/recepients/new'
            end
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

    get '/recepients/:id/deliveries/new' do
        if is_logged_in?
            @recepient = Recepient.find_by_id(params[:id])
            @volunteers = Volunteer.all
            erb :'deliveries/new'
        else
            @error_message = "Please log in to create a new delivery!"
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