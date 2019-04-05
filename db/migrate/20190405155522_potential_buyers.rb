class PotentialBuyers < ActiveRecord::Migration
  def change
    create_table :potentialbuyers do |t|
      t.string :name
      t.string :offer
    end
  end
end
