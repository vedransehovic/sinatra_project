require './config/environment'

class VolunteerController < ApplicationController
    get '/volunteers' do
        if is_logged_in? && is_admin?
            @volunteers = Volunteer.all
            erb :'volunteers/index'
        else
            @error_message = "Please log in as an admin"
            erb :"volunteers/login"
        end        
    end

    get '/volunteers/new' do
        if is_logged_in? && is_admin?
            erb :'volunteers/new'
        else
            @error_message = "Please log in as an admin"
            erb :"volunteers/login"
        end  
    end

    post '/volunteers' do
        if is_logged_in? && is_admin?
            @volunteer = Volunteer.new(params)
            if !@volunteer.save #if there are errors report them and repeat the process
                @errors = @volunteer.errors.full_messages
                erb :'volunteers/new'
            else
                #view
                redirect '/volunteers'
            end
        else
            @error_message = "Please log in as an admin"
            erb :"volunteers/login"
        end  
    end

    get '/volunteers/login' do
        #view
        erb :'volunteers/login'
    end

    post '/volunteers/login' do
        @volunteer = Volunteer.find_by(email: params[:email])
        if @volunteer && @volunteer.authenticate(params[:password])
            session[:volunteer_id] = @volunteer.id
            redirect to '/deliveries'
        else
            @error_message = "Invalid email or password, please try again!"
            erb :'volunteers/login'
        end
    end

    get '/volunteers/:id/edit' do
        if is_logged_in? && is_admin?
            @volunteer=Volunteer.find_by_id(params[:id])
            #view
            erb :'volunteers/edit'        
        else
            @error_message = "Please log in as an admin"
            erb :"volunteers/login"
        end 
    end

    patch '/volunteers/:id' do
        if is_logged_in? && is_admin?
            @volunteer = Volunteer.find_by_id(params[:id])
            params.delete(:_method) #had to delete this so I could run .update(params) on the next line. 
            if !@volunteer.update(params) #if there are errors report them and repeat the process
                @errors = @volunteer.errors.full_messages
                erb :'volunteers/edit'
            else
                #view
                redirect '/volunteers'
            end
        else
            @error_message = "Please log in as an admin"
            erb :"volunteers/login"
        end 
    end

    delete '/volunteers/:id' do
        if is_logged_in? && is_admin?
            Volunteer.delete(params[:id])
            redirect '/volunteers'
        else
            @error_message = "Please log in as an admin"
            erb :"volunteers/login"
        end  
    end

    get '/volunteers/logout' do
        session.clear
        redirect '/deliveries'
    end
end