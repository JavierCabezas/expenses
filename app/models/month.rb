class Month < ActiveRecord::Base
  has_many :expenditures

  validates_uniqueness_of :month, :scope => :year

  def month_and_year
    self.month.to_s + '/' + self.year.to_s
  end

  def self.hash_month_and_year
    months = Month.all

    Hash[months.map{|instance|[instance.month_and_year, instance.id]}]

  end
end
