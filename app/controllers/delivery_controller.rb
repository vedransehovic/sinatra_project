require './config/environment'

class DeliveryController < ApplicationController
    get '/deliveries' do
        @deliveries = Delivery.all 
        #view
        erb :'deliveries/index'
    end

    get '/deliveries/:id' do
        @delivery = Delivery.find_by_id(params[:id])
        #view
        erb :'deliveries/show'
    end

end