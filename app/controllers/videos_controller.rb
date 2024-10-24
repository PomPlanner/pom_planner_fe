class VideosController < ApplicationController
  before_action :set_user

  def create
    response = pom_planner_service.add_favorite_video(@user.id, video_params)

    if response[:status] == 201
      @favorite_videos = pom_planner_service.get_favorite_videos(@user.id)
      @was_empty = @favorite_videos.empty?
      Rails.logger.debug "Appending video #{@favorite_videos.last.title} to list"
      flash.now[:notice] = "Video added to favorites"
      
      respond_to do |format|
        format.html { redirect_to user_path(@user.id), notice: "Video added to favorites" }
        format.turbo_stream
      end
    else
      flash.now[:alert] = "Failed to add video to favorites"
      
      respond_to do |format|
        format.html { redirect_to user_path(@user.id), alert: "Failed to add video to favorites" }
        format.turbo_stream
      end
    end
  end

  def destroy
    response = pom_planner_service.remove_favorite_video(@user.id, params[:id])

    if response[:status] == 200
      @favorite_videos = pom_planner_service.get_favorite_videos(@user.id)
      flash.now[:notice] = "Video removed from favorites"
      
      respond_to do |format|
        format.html { redirect_to user_path(@user.id), notice: "Video removed from favorites" }
        format.turbo_stream
      end
    else
      flash.now[:alert] = "Failed to remove video from favorites"
      
      respond_to do |format|
        format.html { redirect_to user_path(@user.id), alert: "Failed to remove video from favorites" }
        format.turbo_stream
      end
    end
  end

  def create_pom_event
    description = params[:description]

    # Generate the Google Calendar link
    event_link = "https://www.google.com/calendar/render?action=TEMPLATE"
    event_link += "&text=Pomodoro+Event+with+Video"
    event_link += "&details=Watch+this+video:+#{URI.encode_www_form_component(description)}"

    # Return a JavaScript snippet that opens the link in a new window
    respond_to do |format|
      format.js { render js: "window.open('#{event_link}', '_blank', 'width=800,height=600');" }
    end
  end

  private

  def set_user
    @user = pom_planner_service.get_user(session[:user_id])
    unless @user
      Rails.logger.info("Session user_id: #{session[:user_id]}")
      Rails.logger.error("User not found for session user_id: #{session[:user_id]}")
      redirect_to root_path, alert: "User not found"
    end
  end

  def video_params
    params.require(:user_video).permit(:title, :url, :embed_url, :duration, :duration_category)
  end

  def pom_planner_service
    @pom_planner_service ||= PomPlannerService.new
  end
end
