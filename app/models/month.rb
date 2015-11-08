class Month < ActiveRecord::Base
  validates_uniqueness_of :month, :scope => :year
end
