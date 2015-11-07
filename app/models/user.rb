class User < ActiveRecord::Base
  has_many :expenditures

  validates_uniqueness_of :username
end
