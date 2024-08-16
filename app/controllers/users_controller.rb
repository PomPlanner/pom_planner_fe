class UsersController < ApplicationController
  before_action :require_login, only: [:show]

  def show
    user_id = params[:id].to_i
    @user = pom_planner_service.get_user(user_id)
    
    unless @user
      redirect_to root_path, alert: "User not found"
      return
    end

    @favorite_videos = pom_planner_service.get_favorite_videos(user_id)

    if params[:clear_search].present?
      @videos = []
    elsif params[:q].present? && params[:duration].present?
      @videos = pom_planner_service.search_videos(params[:q], params[:duration])
    else
      @videos = []
      flash[:alert] = "Please select at least one category and duration." if request.get? && params[:commit] == "Search"
    end
  end

  private

  def pom_planner_service
    @pom_planner_service ||= PomPlannerService.new
  end

  def require_login
    unless session[:user_id]
      redirect_to root_path, alert: "You must be logged in to access this section"
    end
  end
end
