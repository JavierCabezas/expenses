class AddUserReferenceToExpenditures < ActiveRecord::Migration
  def change
    add_reference :expenditures, :user, index: true, foreign_key: true
  end
end
