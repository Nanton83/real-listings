class Listing < ActiveRecord::Base
    belongs_to :agent
    has_many :potential_buyers
end 