class SearchController < ApplicationController
  def show
    query = params[:q]
    duration = params[:duration]
    @videos = pom_planner_service.search_videos(query, duration)
  end

  private

  def pom_planner_service
    @pom_planner_service ||= PomPlannerService.new
  end
end