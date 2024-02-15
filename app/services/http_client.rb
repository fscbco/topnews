class HttpClient
  attr_implement :base_url

  def get(url)
    response = Faraday.new(base_url).get(url)
  end
end
