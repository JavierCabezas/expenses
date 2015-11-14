class AddUserReferenceToIsUserInHouse < ActiveRecord::Migration
  def change
    add_reference :is_user_in_houses, :user, index: true
  end
end
