class User < ActiveRecord::Base
  has_many :expenditures
end
