class PomPlannerService
  def conn
    Faraday.new(url: "http://localhost:5000") do |faraday|
      faraday.use :cookie_jar
      faraday.headers['Content-Type'] = 'application/json'
      faraday.headers['Accept'] = 'application/json'
    end
  end

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def post_url(url, params)
    response = conn.post(url) do |req|
      req.body = params.to_json
    end
    JSON.parse(response.body, symbolize_names: true).merge(status: response.status)
  end
  
  def delete_url(url)
    response = conn.delete(url)
    conn.builder.handlers.delete(:cookie_jar)
    { status: response.status }
  end

  def get_user(user_id)
    data = get_url("/api/v1/users/#{user_id}")

    if data.key?(:data) && data[:data].key?(:attributes)
      attributes = data[:data][:attributes]
      User.new(attributes.transform_keys(&:to_sym))
    else
      Rails.logger.error("Failed to fetch user data for user #{user_id}")
      nil
    end
  end
  
  def search_videos(query, duration)
    data = get_url("/api/v1/search?query=#{query}&video_duration=#{duration}")
    data[:data].map { |video_data| Video.new(video_data[:attributes]) }
  end

  def add_favorite_video(user_id, video_params)
    post_url("/api/v1/users/#{user_id}/videos", { video: video_params })
  end

  def get_favorite_videos(user_id)
    data = get_url("/api/v1/users/#{user_id}/videos")
    data[:data].map do |video_data|
      attributes = video_data[:attributes].merge(id: video_data[:id])
      Video.new(attributes)
    end
  end

  def remove_favorite_video(user_id, video_id)
    delete_url("/api/v1/users/#{user_id}/videos/#{video_id}")
  end
end
