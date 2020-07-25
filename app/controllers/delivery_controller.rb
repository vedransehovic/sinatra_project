require './config/environment'

class DeliveryController < ApplicationController
    get '/deliveries' do #show active deliveries only
        @active = true
        @deliveries = Delivery.where(completed: nil).order("date DESC")
        #view
        erb :'deliveries/index'
    end

    get '/deliveries/all' do #show all deliveries
        @deliveries = Delivery.all.order("date DESC")
        #view
        erb :'deliveries/index'
    end
    
    #creating deliveries consists of 2 parts. Choosing or creating a recepient and creating a delivery.

    get '/deliveries/new/recepient' do
        #view
        erb :'deliveries/new_delivery_recepient'
    end

    post '/deliveries' do
        if is_logged_in?
            Delivery.create(params)
            #view
            redirect to '/deliveries'
        else
            @error_message = "Please log in to create a delivery!"
            erb :"volunteers/login"
        end 
    end


    get '/deliveries/:id/edit' do
        if is_logged_in?
            @delivery=Delivery.find_by_id(params[:id])
            @volunteers=Volunteer.all
            #view
            erb :'deliveries/edit'
        else
            @error_message = "Please log in to edit a recepient!"
            erb :"volunteers/login"
        end 
    end

    post '/deliveries/:id/complete' do
        if is_logged_in?
            delivery=Delivery.find_by_id(params[:id])
            delivery.update(completed: params[:completed])
            redirect '/deliveries'
        else
            @error_message = "Please log in to edit a delivery!"
            erb :"volunteers/login"
        end 
    end

    patch '/deliveries/:id' do
        if is_logged_in?
            delivery = Delivery.find_by_id(params[:id])
            params.delete(:_method)
            delivery.update(params)
            #view
            redirect '/deliveries'
        else
            @error_message = "Please log in to edit a delivery!"
            erb :"volunteers/login"
        end 
    end

    delete '/deliveries/:id' do
        if is_logged_in?
            delivery = Delivery.find_by_id(params[:id])
            delivery.delete
            redirect '/deliveries'
        else
            @error_message = "Please log in to delete a delivery!"
            erb :"volunteers/login"
        end 
    end

end