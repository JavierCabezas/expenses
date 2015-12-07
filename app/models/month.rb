class Month < ActiveRecord::Base
  has_many :expenditures
  has_many :is_user_in_houses

  validates_uniqueness_of :month, :scope => :year

  #Returns the month and year (in text) of the instance of this model. Ex: November / 2015.
  def month_and_year
    Date::MONTHNAMES[self.month] + '/' + self.year.to_s
  end

  #This function recieves a date in the format YYYY-MM-DD and gets the month_id of it.
  #If there is no date with that ID on the database it returns -1.
  def self.give_month_id_by_date(date)
    month = date.to_date.month
    year = date.to_date.year
    model = Month.where(month:month, year:year).first

    return model ? model.id : -1

  end

  def self.hash_month_and_year
    months = Month.all

    Hash[months.map{|instance|[instance.month_and_year, instance.id]}]

  end

  def self.get_current_month_id
    m = Month.where(month: Date.today.strftime("%m"), year: Date.today.strftime("%Y")).first
    if(m)
      return m.id
    else
      return Month.first.id
    end
  end
end
