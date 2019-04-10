class AgentListings < ActiveRecord::Migration
  def change
    create_table :agent_listings do |t|
      t.integer :agent_id
      t.integer :listing_id
      t.integer :potential_buyer_id
    end
  end
end
