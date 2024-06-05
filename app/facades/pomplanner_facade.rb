class PomPlannerFacade

  def user_videos
    service = PomPlannerService.new
    json = service.get_user_videos

    @videos = json.map do |video|
      Video.new(video[:attributes])
    end
  end

  def search_results
    service = PomPlannerService.new
    json = service.get_search_results

    @results = json.map do |result|
      Search.new(result[:attributes])
    end
  end
end