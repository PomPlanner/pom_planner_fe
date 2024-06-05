class PomPlanner
  attr_reader :video_url,
              :video_name,
              :user_favorite_videos

  def initialize(attributes)
    @video_url = attributes[:VIDURL]
    @video_name = attributes[:VIDNAME]
    @user_favorite_videos = attributes[:USERFAVES]
  end
  
end