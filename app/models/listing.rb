class Listing < ActiveRecord::Base
    has_many :agent_listings
    has_one :agents, through: :agent_listings
    has_many :potential_buyers, through: :agent_listings
end 