class Agent < ActiveRecord::Base
    has_many :listings
    validates :user_name, uniqueness: true
    has_secure_password
    
    
end 