class VideosController < ApplicationController
  before_action :set_user

  def create
    response = pom_planner_service.add_favorite_video(@user.id, video_params)
    if response[:status] == 201
      @favorite_videos = pom_planner_service.get_favorite_videos(@user.id)
      @videos = pom_planner_service.search_videos(params[:query], params[:duration])
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.replace("favorite-videos", partial: "videos/favorite_videos", locals: { favorite_videos: @favorite_videos }) }
        format.html { redirect_to user_path(@user.id), notice: "Video added to favorites" }
      end
    else
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.replace("favorite-videos", partial: "videos/favorite_videos", locals: { favorite_videos: [] }) }
        format.html { redirect_to user_path(@user.id), alert: "Failed to add video to favorites" }
      end
    end
  end


  def destroy
    response = pom_planner_service.remove_favorite_video(@user.id, params[:id])
    if response.status == 200
      @favorite_videos = pom_planner_service.get_favorite_videos(@user.id)
      Rails.logger.debug "Favorite videos after delete: #{@favorite_videos.inspect}"
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.replace("favorite-videos", partial: "videos/favorite_videos", locals: { favorite_videos: @favorite_videos }) }
        format.html { redirect_to user_path(@user.id), notice: "Video removed from favorites" }
      end
    else
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.replace("favorite-videos", partial: "videos/favorite_videos", locals: { favorite_videos: [] }) }
        format.html { redirect_to user_path(@user.id), alert: "Failed to remove video from favorites" }
      end
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
