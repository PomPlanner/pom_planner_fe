class Video
  attr_reader :id, :title, :url, :embed_url

  def initialize(data)
    # require 'pry'; binding.pry
    @id = data[:id]
    @title = data[:title]
    @url = data[:url]
    @embed_url = data[:embed_url]
  end
end