class Video
  attr_reader :id, :title, :url, :embed_url, :duration, :category

  def initialize(data)
    # require 'pry'; binding.pry
    @id = data[:id]
    @title = data[:attributes][:title]
    @url = data[:attributes][:url]
    @embed_url = data[:attributes][:embed_url]
    @duration = data[:attributes][:duration]
    @category = data[:attributes][:category]
  end
end