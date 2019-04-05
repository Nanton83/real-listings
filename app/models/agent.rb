class Agent < ActiveRecord::Base
    has_many :listings
    has_secure_password
end 