class IsUserInHouseControllerController < ApplicationController
  def index
    @is = IsUserInHouse.order('user_id DESC, month_id ASC, day ASC').all
  end
end
