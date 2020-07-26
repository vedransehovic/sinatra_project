- This is a Flatiron course Sinatra project.
It is intended to be a barebones database system for managing deliveries for a group of volunteers.
Database schema consists of 3 tables: Recepients, Volunteers (users), and Deliveries. Recepients and Volunteers are connected via "has many through" relationship, deliveries being the connecting table. Deliveries belong to both volunteers and recepients and both can have "many" deliveries. That setup provides maximum elasticity for the project. You can find detailed PDF of database schema with tables and corresponding fields in "notes" folder.

- Session secret is written in .env file. It will be excluded from github via .gitignore file (it means that you will have to generate your own secret once you download the project. Create .env file and add a line of code that starts with SESSION_SECRET="" Your secret code should be between quotations.)

- Once you download the project run "bundle install" to install all missing gems. 
Gems included in this project are:
- gem 'sinatra'
- gem 'activerecord', '~> 4.2', '>= 4.2.6', :require => 'active_record'
- gem 'sinatra-activerecord', :require => 'sinatra/activerecord'
- gem 'rake'
- gem 'require_all'
- gem 'sqlite3', '~> 1.3.6'
- gem 'thin'
- gem 'shotgun'
- gem 'pry'
- gem 'bcrypt'
- gem 'tux'
- gem 'dotenv'
- gem 'rspec'
- gem 'capybara'
- gem 'rack-test'
- gem 'database_cleaner', git: 'https://github.com/bmabey/database_cleaner.git'

- When you have gems installed run "shotgun" in your terminal to start the local webserver and go to "localhost:9393" in your browser to run the project. 
- To test Administrative privileges use following login:
    U: admin@dot.com
    P: password
- To test regular user privileges use:
    U: layla@gmail.com
    P: password

- Just a small change to readme to test the branch

