require './config/environment'

class DeliveryController < ApplicationController
    get '/deliveries' do
        @deliveries = Delivery.all 
        #view
        erb :'deliveries/index'
    end
    
    #creating deliveries consists of 2 parts. Choosing or creating a recepient and creating a delivery.

    get '/deliveries/new/recepient' do
        #view
        erb :'deliveries/new_delivery_recepient'
    end

    post '/deliveries/new/recepient' do
        @today = DateTime.now.strftime("%Y-%m-%d")  #setting today's date as default calendar value
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

    post '/deliveries/new' do
        Delivery.create(params)
        #view
        redirect to '/deliveries'
    end

    get '/deliveries/:id' do
        @delivery = Delivery.find_by_id(params[:id])
        #view
        erb :'deliveries/show'
    end

end