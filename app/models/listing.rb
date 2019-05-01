class Listing < ActiveRecord::Base
    belongs_to :agent
    has_many :potential_buyers      #future addition to app that will show people interested in buying properties
end 