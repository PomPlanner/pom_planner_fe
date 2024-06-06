class UsersController < ApplicationController

  def show
    user_id = params[:id]
  
    @user = pom_planner_service.get_user(user_id)
    @favorite_videos = pom_planner_service.get_favorite_videos(user_id)
    # user_data = pom_planner_service.get_user(user_id)

    # if user_data
    #   @user = user_data[:user]
    #   @favorite_videos = user_data[:favorite_videos]
    # else
    #   redirect_to root_path, alert: "User not found"
    unless @user
      redirect_to root_path, alert: "User not found"
    end
  end

  private

  def pom_planner_service
    @pom_planner_service ||= PomPlannerService.new
  end
end