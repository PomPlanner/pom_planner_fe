class Video
  attr_reader :id, :title, :url, :embed_url, :duration, :duration_category

  def initialize(attributes)
    @id = attributes[:id]
    @title = attributes[:title]
    @url = attributes[:url]
    @embed_url = attributes[:embed_url]
    @duration = attributes[:duration]
    @duration_category = attributes[:duration_category]
  end
end
