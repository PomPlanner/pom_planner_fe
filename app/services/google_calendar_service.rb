class GoogleCalendarService
  def connection
    Faraday.new(url: "http://localhost:5000")
  end

  def get_url(url)
    response = connection.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end
end