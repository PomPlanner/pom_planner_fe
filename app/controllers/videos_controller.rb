class VideosController < ApplicationController
  before_action :set_user

  def index
    @videos = pom_planner_service.get_favorite_videos(@user.id)
  end

  def create
    # require 'pry'; binding.pry
    response = pom_planner_service.add_favorite_video(@user.id, video_params)
    if response[:status] == 201
    # if response.success?
      redirect_to user_path(@user.id), notice: "Video added to favorites"
    else
      redirect_to user_path(@user.id), alert: "Failed to add video to favorites"
    end
  end

  def destroy
    response = pom_planner_service.remove_favorite_video(@user.id, params[:id])
    # require 'pry'; binding.pry
    if response.status == 200
      redirect_to user_path(@user.id), notice: "Video removed from favorites"
    else
      redirect_to user_path(@user.id), alert: "Failed to remove video from favorites"
    end
  end

  private

  def set_user
    @user = pom_planner_service.get_user(session[:user_id])
    unless @user
      redirect_to root_path, alert: "User not found"
    end
  end

  def video_params
    params.require(:video).permit(:title, :url, :embed_url, :duration, :duration_category)
  end

  def pom_planner_service
    @pom_planner_service ||= PomPlannerService.new
  end
end
