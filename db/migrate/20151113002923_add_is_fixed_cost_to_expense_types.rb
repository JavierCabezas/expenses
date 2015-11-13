class AddIsFixedCostToExpenseTypes < ActiveRecord::Migration
  def change
    add_column :expense_types, :is_fixed_cost, :boolean, default: false
  end
end
