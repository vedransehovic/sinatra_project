require './config/environment'

class DeliveryController < ApplicationController
    get '/deliveries' do
        @deliveries = Delivery.all.order("date DESC")
        #view
        erb :'deliveries/index'
    end
    
    #creating deliveries consists of 2 parts. Choosing or creating a recepient and creating a delivery.

    get '/deliveries/new/recepient' do
        #view
        erb :'deliveries/new_delivery_recepient'
    end

    post '/deliveries/new/recepient' do
        @volunteers = Volunteer.all #selecting all volunteers for populating the pulldown
        if params[:lookup] != ''
            @recepients = Recepient.search(params[:lookup]) #looking up recepients
            #view
            erb :'deliveries/new'
        else
            @recepient = Recepient.create(name: params[:name], address: params[:address], municipality: params[:municipality], phone: params[:phone])
            erb :'deliveries/new'
        end
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

    patch '/deliveries/:id' do
        if is_logged_in?
            delivery = Delivery.find_by_id(params[:id])
            delivery.task = params[:task]
            delivery.date = params[:date]
            delivery.recepient_id = params[:recepient_id]
            delivery.volunteer_id = params[:volunteer_id]
            delivery.save
            #view
            redirect '/deliveries'
        else
            @error_message = "Please log in to edit a delivery!"
            erb :"volunteers/login"
        end 
    end

    delete '/deliveries/:id' do
        if is_logged_in? && is_admin?
            Delivery.delete(params[:id])
            redirect '/deliveries'
        else
            @error_message = "Please log in as an admin"
            erb :"volunteers/login"
        end  
    end

end