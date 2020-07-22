require './config/environment'

class RecepientController < ApplicationController
    get '/recepients' do
        # if searching to create new delivery
        #find recipients
        #render delivery/new with recipients
        @recepients = Recepient.all

        #view
        erb :'recepients/index'
    end

    get '/recepients/new' do
        #view
        erb :'recepients/new'
    end

    post '/recepients/new' do
      
        Recepient.create(params)
        # r= Recepient.new(params)
        #if r.save
        # redirect as normal
        #else 
        #def error(r.errors.full_messages) and rerender form

        # make a check to determine redirect
        # if creating new delivery
        # redirect recipients/:recipient_id/deliveries/new
        redirect '/recepients'
    end

    get '/recepients/:id/edit' do
        @recepient=Recepient.find_by_id(params[:id])
        #view
        erb :'recepients/edit'
    end

    patch '/recepients/:id' do
        recepient = Recepient.find_by_id(params[:id])
        recepient.name = params[:name]
        recepient.address = params[:address]
        recepient.municipality = params[:municipality]
        recepient.phone = params[:phone]
        recepient.save
        #view
        redirect '/recepients'
    end

    delete '/recepients/:id' do
        Recepient.delete(params[:id])
        redirect '/recepients'
    end
end