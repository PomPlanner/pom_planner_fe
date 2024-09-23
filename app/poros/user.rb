class User
  attr_reader :id, :name, :email, :image, :favorite_videos

  def initialize(data)
    @id = data[:id]
    @name = data[:name]
    @email = data[:email]
    @image = data[:image]
    @favorite_videos = data[:favorite_videos]&.map { |video_data| Video.new(video_data) }
  end
end