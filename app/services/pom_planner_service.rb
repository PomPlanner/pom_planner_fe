class PomPlannerService
  def conn
    Faraday.new(url: "http://localhost:5000")
  end

  def get_url(url)
    response = conn.get(url)
    # require 'pry'; binding.pry
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
    # data = get_url("/api/v1/users/#{user_id}")
    # require 'pry'; binding.pry
    # User.new(data[:data][:attributes].transform_keys(&:to_sym))
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
    data = get_url("/api/v1/searches?query=#{query}&video_duration=#{duration}")
    data[:videos].map { |video_data| Video.new(video_data) }
  end

  def add_favorite_video(user_id, video_params)
    post_url("/api/v1/users/#{user_id}/user_videos", { user_video: video_params })
  end

  def get_favorite_videos(user_id)
    response = conn.get("/api/v1/users/#{user_id}/user_videos")
    if response.success?
      data = JSON.parse(response.body, symbolize_names: true)
      if data.empty? || data.first.key?(:message)
        Rails.logger.info("No favorite videos found for user #{user_id}.")
        return [] # Return an empty array when no favorite videos are found
      else
        return data.map { |video_data| Video.new(video_data) } # Return an array of Video objects
      end
    else
      Rails.logger.error("Failed to fetch favorite videos for user #{user_id}.")
      return [] # Return an empty array on failure
    end
  rescue JSON::ParserError => e
    Rails.logger.error("Error parsing JSON response: #{e.message}")
    return [{ message: "Error fetching favorite videos." }] # Return a specific message if JSON parsing fails
  end

  def remove_favorite_video(user_id, video_id)
    delete_url("/api/v1/users/#{user_id}/user_videos/#{video_id}")
  end
end