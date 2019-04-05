class Listings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
      t.string :address
      t.string :bedrooms
      t.string :bathrooms
      t.string :square_feet
      t.string :price
    end
  end
end
