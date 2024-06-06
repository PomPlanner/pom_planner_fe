class PomPlannerService
  def conn
    Faraday.new(url: "http://localhost:5000")
  end

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def post_url(url, params)
    response = conn.post(url) do |req|
      req.headers['Content-Type'] = 'application/json'
      req.body = params.to_json
    end
    JSON.parse(response.body, symbolize_names: true)
  end
  
  def delete_url(url)
    response = conn.delete(url)
    response.success?
  end

  def get_user(user_id)
    # require 'pry'; binding.pry
    # get_url("/api/v1/users/#{user_id}")
    data = get_url("/api/v1/users/#{user_id}")
    # require 'pry'; binding.pry
    User.new(data)
  end
  
  def search_videos(query, duration)
    # get_url("/api/v1/searches?query=#{query}&video_duration=#{duration}")
    data = get_url("/api/v1/searches?query=#{query}&video_duration=#{duration}")
    data[:videos].map { |video_data| Video.new(video_data) }
  end

  def add_favorite_video(user_id, video_params)
    post_url("/api/v1/users/#{user_id}/user_videos", { user_video: video_params })
  end

  def get_favorite_videos(user_id)
    response = conn.get("/api/v1/users/#{user_id}/user_videos")
    if response.body.present?
      JSON.parse(response.body, symbolize_names: true)
    else
      [] 
    end
  end

  def remove_favorite_video(user_id, video_id)
    delete_url("/api/v1/users/#{user_id}/user_videos/#{video_id}")
  end
end