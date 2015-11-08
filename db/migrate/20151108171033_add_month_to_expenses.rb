class AddMonthToExpenses < ActiveRecord::Migration
  def change
    add_reference :expenditures, :month, index: true, foreign_key: true
  end
end
