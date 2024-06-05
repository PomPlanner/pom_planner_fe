class PomPlannerService
  def conn
    Faraday.new(url: "http://localhost:5000")
  end

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def delete_url(url)
    response = conn.delete(url)
    response.success?
  end

  def self.get_user_videos
    get_url("/api/v1/user_videos")
  end

  def get_search_results
    get_url("/api/v1/searches")
  end
end