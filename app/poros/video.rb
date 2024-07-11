class Video
  attr_reader :id, :title, :url, :embed_url, :duration, :duration_category

  def initialize(data)
    # require 'pry'; binding.pry
    @id = data[:id]
    @title = data[:attributes][:title]
    @url = data[:attributes][:url]
    @embed_url = data[:attributes][:embed_url]
    @duration = data[:attributes][:duration]
    @duration_category = data[:attributes][:duration_category]
  end
end