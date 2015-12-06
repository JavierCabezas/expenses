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
  def self.expense_ponderation_constant( expense, user_id )
    if user_id == expense.user_id #If the user already payed the bill then he/she shouldn't be considered to pay it again (of course)
      return 0
    end

    if expense.expense_type.is_fixed_cost
      number_of_users = User.all.count()
      return 1.to_f / number_of_users if number_of_users > 0
    else
      days_user        = IsUserInHouse.where(was_at_home: true, month_id: expense.month_id, user_id: user_id).count()
      days_all_users   = IsUserInHouse.where(was_at_home: true, month_id: expense.month_id).count()
      return days_user.to_f / days_all_users if days_all_users != 0
    end
  end

  #Virtual attribute for the reason of the bill
  #Format: (type_of_bill) (date)
  def reason
    return self.expense_type.name + ' for ' + self.created_at.to_s(:short)
  end


  def self.expenditures_per_user( expenditures, users )
    out = {}

    users.each do |usr|
      out[usr.username] = {}
      out[usr.username]['details'] = []
      out[usr.username]['totals'] = {}
      out[usr.username]['totals']['Sum'] = 0 #This is the combined ammount
      users.each do |usr2|
        out[usr.username]['totals'][usr2.username] = 0 #This is the ammount per user
      end
    end

    expenditures.each do |exp|
      users.each do |usr|
        if exp.user_id != usr.id
          proportion_constant = Expenditure.expense_ponderation_constant( exp, usr.id )
          ammount = (exp.ammount * proportion_constant).to_i
          temp = { }
          temp['ammount'] =  ammount
          temp['pay_to'] = exp.user.username
          temp['because'] = exp.reason
          out[usr.username]['totals']['Sum'] += ammount
          out[usr.username]['totals'][exp.user.username] += ammount
          out[usr.username]['details'].push( temp )
        end
      end
    end

    return out

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
