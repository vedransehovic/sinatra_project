require './config/environment'

class RecepientController < ApplicationController
    get '/recepients' do
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