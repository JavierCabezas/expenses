class Expenditure < ActiveRecord::Base
  belongs_to :expense_type
  belongs_to :month
  belongs_to :user

  def self.array_statuses
    ['Overdue', 'Payed', 'Invalid']
  end

  #@todo: Make these two functions not suck.
  def self.array_chart_expense_type
    out = Hash.new
    arr = Expenditure.group(:expense_type_id).sum(:ammount).map{ |expe|
      out[ ExpenseType.find_by_id(expe[0]).name] = expe[1]
    }
    out
  end

  def self.array_chart_expense_by_user
    out = Hash.new
    arr = Expenditure.group(:user_id).sum(:ammount).map{ |expe|
      out[ User.find_by_id(expe[0]).username] = expe[1]
    }
    out
  end

end
