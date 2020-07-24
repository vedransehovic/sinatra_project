require './config/environment'

class RecepientController < ApplicationController
    get '/recepients' do
        not_logged_in? ("Please log in to make changes to recepients.")
        if params[:lookup] #checking if recepient query exists (on delivery creation)
            @recepients = Recepient.search(params[:lookup])
        else 
            @recepients = Recepient.all
        end
        #view
        erb :'recepients/index'
    end

    post '/recepients' do
        not_logged_in? ("Please log in.")
        Recepient.create(params)
        redirect '/recepients'
    end

    get '/recepients/new' do
        not_logged_in? ("Please log in to create a new recepient.")
        #view
        erb :'recepients/new'
    end

    post '/recepients/new' do #NEED HELP REFACTORING
        not_logged_in? ("Please log in to create a new recepient.")
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
    end

    get '/recepients/:id/deliveries/new' do
        not_logged_in? ("Please log in to create a new delivery.")
            @recepient = Recepient.find_by_id(params[:id])
            @volunteers = Volunteer.all
            erb :'deliveries/new'
    end

    get '/recepients/:id/edit' do
        not_logged_in? ("Please log in to edit a recepient.")
        @recepient=Recepient.find_by_id(params[:id])
        #view
        erb :'recepients/edit'
    end

    patch '/recepients/:id' do
        not_logged_in? ("Please log in to edit a recepient.")
        @recepient = Recepient.find_by_id(params[:id])
        params.delete(:_method) #had to delete this so I could run .update(params) on the next line. 
        if !@recepient.update(params) #if there are errors report them and repeat the process
            @errors = @recepient.errors.full_messages
            erb :'recepients/edit'
        else
            #view
            redirect '/recepients'
        end
        # recepient.name = params[:name]
        # recepient.address = params[:address]
        # recepient.municipality = params[:municipality]
        # recepient.phone = params[:phone]
        # recepient.save
        #view
        redirect '/recepients'
    end

    delete '/recepients/:id' do
        if is_logged_in? && is_admin?
            Recepient.delete(params[:id])
            redirect '/recepients'
        else
            session[:error_message] = "Please log as an admin to delete a recepient!"
            erb :"volunteers/login"
        end 
    end
end