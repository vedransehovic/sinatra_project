class Delivery < ActiveRecord::Base
    belongs_to :recepient
    belongs_to :volunteer

    def self.by_municipality #counts all deliveries grouped by municipality
        Delivery
        .joins("JOIN recepients ON deliveries.recepient_id=recepients.id")
        .group("recepients.municipality")
        .count
    end

    def self.by_date #count of all deliveries grouped by date
        Delivery.group(:date).order(date: :desc).limit(10).count
    end

    def self.total_deliveries #total nuamber of deliveries
        Delivery.where(completed: true).count
    end

    def self.active_deliveries #deliveries that have not been completed
        self.where(completed: [false, nil]).count
    end

    #validates :volunteer_id, presence: true
    #validates :recepient, presence: true
end