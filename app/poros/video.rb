class Video
  attr_reader :id, :title, :url, :embed_url, :duration, :duration_category

  def initialize(data)
    # require 'pry'; binding.pry
    @id = data[:id]
    @title = data[:title]
    @url = data[:url]
    @embed_url = data[:embed_url]
    @duration = data[:duration]
    @duration_category = data[:duration_category]
  end
end