class Expenditure < ActiveRecord::Base
  has_one :expense_type
  belongs_to :user
end
