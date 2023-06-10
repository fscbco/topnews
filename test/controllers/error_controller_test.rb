require 'test_helper'

class ErrorsControllerTest < ActionDispatch::IntegrationTest
  test "should render not found page" do
    get "/errors/not_found"

    assert_response :not_found
  end
end