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
  # This function returns the constant that the user will be multiplied for each of the expenses.
  # This can be calculated by two different methods:
  #    1) If the bill has a fixed cost (that means that it does not matter if you were at home or not for the bill to go up) then we just divide by the number of users.
  #    2) If the bill is variable its calculated by getting the days that you were at home and then divided by the number of days that the others were at home
  #
  def expense_ponderation_constant( month_id, user_id, expense)
    if expense.expense_type.is_fixed_cost
        number_of_users = User.all.count()
        return 1 / number_of_users
    else
      days_user        = IsUserInHouse.where(was_at_home: true, month_id: month_id, user_id: user_id).count()
      days_other_users = IsUserInHouse.where(was_at_home: true, month_id: month_id).count() - days_user
      return days_user / days_other_users
    end
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
