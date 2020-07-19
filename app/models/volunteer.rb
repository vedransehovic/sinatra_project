class Volunteer < ActiveRecord::Base
    has_many :deliveries
    has_many :recepients, through: :deliveries

    has_secure_password

end