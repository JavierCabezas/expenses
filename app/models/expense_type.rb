class ExpenseType < ActiveRecord::Base
  belongs_to :expenditure

  validates_uniqueness_of :name
end
