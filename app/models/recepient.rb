class Recepient < ActiveRecord::Base
    has_many :deliveries
    has_many :volunteers, through: :deliveries
end 