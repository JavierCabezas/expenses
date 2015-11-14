class IsUserInHouse < ActiveRecord::Base
  belongs_to :user
  belongs_to :month

  validates_uniqueness_of :day, :scope => [:month_id, :user_id]
end
