require 'test_helper'

class MyBlogControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

end
