class Listings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
      t.integer :agent_id
      t.string :address
      t.integer :bedrooms
      t.integer :bathrooms
      t.integer :square_feet
      t.integer :price
    end
  end
end
