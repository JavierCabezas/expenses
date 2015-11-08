class Expenditure < ActiveRecord::Base
  has_one :expense_type
  has_one :month
  belongs_to :user
end
