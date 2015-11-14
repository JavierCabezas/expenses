class CreateIsUserInHouses < ActiveRecord::Migration
  def change
    create_table :is_user_in_houses do |t|
      t.integer :month_id
      t.integer :user_id
      t.integer :day
      t.boolean :was_at_home

      t.timestamps
    end
  end
end
