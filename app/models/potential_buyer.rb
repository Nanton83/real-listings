class PotentialBuyer < ActiveRecord::Base
    has_many :agent_listings
    has_many :listings, through: :agent_listings
end 