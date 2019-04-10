class Agent < ActiveRecord::Base
    has_many :agent_listings
    has_many :listings, through: :agent_listings
    has_secure_password
end 