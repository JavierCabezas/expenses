class AddExpenseTypeReferenceToExpenditures < ActiveRecord::Migration
  def change
    add_reference :expenditures, :expense_type, index: true, foreign_key: true
  end
end
