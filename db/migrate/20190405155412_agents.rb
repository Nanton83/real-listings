class Agents < ActiveRecord::Migration
  def change
    create_table :agents do |t|
      t.string :user_name
      t.string :email
      t.string :password_digest
    end
  end
end
