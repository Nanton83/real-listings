class AgentListing < ActiveRecord::Base
    belongs_to :agent
    belongs_to :listing
    belongs_to :potential_buyer
end