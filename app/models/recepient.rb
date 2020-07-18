class Recepient < ActiveRecord::Base
    has_many :deliveries
    has_many :volunteers, through: :deliveries

    def self.search(query)
        Recepient.where('name LIKE ?', "%#{query}%")
    end
end 