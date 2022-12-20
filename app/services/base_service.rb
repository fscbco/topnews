# Base service class. Subclass and override #execute.
class BaseService
  attr_reader :request_uri

  def initialize(request_uri)
    raise ArgumentError, 'request_uri is blank?' if request_uri.blank?

    @request_uri = request_uri
  end

  # Initiate the service call and returns the result; typically:
  # response = request
  #
  # Check status and act accordingly (4xx and 5xx will raise automatically):
  # xxxx unless response.status == 200
  #
  # Assuming a JSON payload:
  # JSON.parse(response.body)
  def execute
    raise NotImplementedError
  end

  private

  def request
    connection.get(request_uri)
  end

  def connection
    Faraday.new do |conn|
      conn.options.timeout = request_timeout
      # raises errors on 4XX or 5XX responses
      conn.response :raise_error
    end
  end

  def request_timeout
    5
  end
end
