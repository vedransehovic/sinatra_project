class Recepient < ActiveRecord::Base
    has_many :deliveries
    has_many :volunteers, through: :deliveries
   # validates :column, :validation(prescence, uniqness, length, etc?)

    def self.search(query)
        Recepient.where('name LIKE ?', "%#{query}%")
    end
end 