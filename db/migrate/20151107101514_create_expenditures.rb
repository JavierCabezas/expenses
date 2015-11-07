class CreateExpenditures < ActiveRecord::Migration
  def change
    create_table :expenditures do |t|
      t.integer :ammount
      t.integer :status
      t.text :comment

      t.timestamps
    end
  end
end
