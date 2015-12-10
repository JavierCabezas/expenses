class IsUserInHouseControllerController < ApplicationController
  def index

    if params['month_id'].present?
      @selected_month_id = params['month_id']
    else
      @selected_month_id = Month.get_current_month_id
    end

    @was_at_home = IsUserInHouse.where(month_id: @selected_month_id).order(:day).all.to_a
    @users = User.all
  end
end
