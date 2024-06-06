class SearchesController < ApplicationController
  def index
    query = params[:query]
    duration = params[:video_duration]
    @videos = pom_planner_service.search_videos(query, duration)
    # @results

    # hard coding the preselected search params
    # random examples; will be changed; fields prob need to be adjusted too
    # @search_params = [
    #   { name: 'workout_type', value: 'cardio', label: 'Cardio', selected: false },
    #   { name: 'workout_type', value: 'stretching', label: 'Stretching', selected: false },
    #   { name: 'workout_type', value: 'yoga', label: 'Yoga', selected: false },
    # ]
  end

  # def show

  # end

  private

  def pom_planner_service
    @pom_planner_service ||= PomPlannerService.new
  end
end