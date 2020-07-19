class Delivery < ActiveRecord::Base
    belongs_to :recepient
    belongs_to :volunteer

    #validates :volunteer_id, presence: true
    #validates :recepient, presence: true
end