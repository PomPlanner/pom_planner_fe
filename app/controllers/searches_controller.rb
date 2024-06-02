class SearchesController < ApplicationController
  def index
    # @results

    # hard coding the preselected search params
    # random examples; will be changed; fields prob need to be adjusted too
    @search_params = [
      { name: 'workout_type', value: 'cardio', label: 'Cardio', selected: false },
      { name: 'workout_type', value: 'stretching', label: 'Stretching', selected: false },
      { name: 'workout_type', value: 'yoga', label: 'Yoga', selected: false },
    ]
  end

  def show

  end
end