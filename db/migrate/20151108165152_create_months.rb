class CreateMonths < ActiveRecord::Migration
  def change
    create_table :months do |t|
      t.integer :month
      t.integer :year
      t.boolean :payed

      t.timestamps
    end
  end
end
