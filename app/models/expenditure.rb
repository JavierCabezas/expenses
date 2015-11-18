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

  ##
  #  This function returns the ammount of a single expenditure that the user has.
  #  It recieves:
  #    expense_per_user: an array that have multiple arrays. Each of these arrays has the format array[0] = expense_id and array[1] = expense ammount.
  #    expenditure_id: the identifier (int) of the expenditure that we are going to check out.
  #
  def self.user_has_expenditure(expense_per_user, expenditure_id)
    if( expense_per_user.empty? ) #If the user has no expenditures then return 0 as the ammount.
      return 0
    end

    expense_per_user.each do |expense|
      if(expense[0] == expenditure_id)
        return expense[1]
      end
    end

    return 0
  end

  def self.array_chart_expense_by_user
    out = Hash.new
    arr = Expenditure.group(:user_id).sum(:ammount).map{ |expe|
      out[ User.find_by_id(expe[0]).username] = expe[1]
    }
    out
  end

end
