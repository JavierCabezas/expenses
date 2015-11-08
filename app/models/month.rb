class Month < ActiveRecord::Base
  has_many :expenditures

  validates_uniqueness_of :month, :scope => :year

  def month_and_year
    Date::MONTHNAMES[self.month] + '/' + self.year.to_s

  end

  def self.hash_month_and_year
    months = Month.all

    Hash[months.map{|instance|[instance.month_and_year, instance.id]}]

  end
end
