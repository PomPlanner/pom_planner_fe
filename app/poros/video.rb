class Video
  attr_reader :id, :title, :url, :thumbnail

  def initialize(data)
    @id = data[:id]
    @title = data[:title]
    @url = data[:url]
    @thumbnail = data[:thumbnail]
  end
end