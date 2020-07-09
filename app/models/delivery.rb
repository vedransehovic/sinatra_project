class Delivery < ActiveRecord::Base
    belongs_to :recepient
    belongs_to :volunteer
end