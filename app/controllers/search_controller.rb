class SearchController < ApplicationController
  def index
    query = params[:q]
    duration = params[:duration]
    @videos = pom_planner_service.search_videos(query, duration)
    binding.pry
  end

  private

  def pom_planner_service
    @pom_planner_service ||= PomPlannerService.new
  end
end