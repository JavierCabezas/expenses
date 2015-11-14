class User < ActiveRecord::Base
  has_many :expenditures
  has_many :is_user_in_houses

  validates_uniqueness_of :username
end
