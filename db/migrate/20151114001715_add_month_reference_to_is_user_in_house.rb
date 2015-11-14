class AddMonthReferenceToIsUserInHouse < ActiveRecord::Migration
  def change
    add_reference :is_user_in_houses, :month, index: true
  end
end
