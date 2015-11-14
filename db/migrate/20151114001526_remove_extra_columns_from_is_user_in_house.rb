class RemoveExtraColumnsFromIsUserInHouse < ActiveRecord::Migration
  def change
    remove_column :is_user_in_houses, :user_id
    remove_column :is_user_in_houses, :month_id
  end
end
