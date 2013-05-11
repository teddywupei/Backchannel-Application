
require 'test_helper'

class AdminControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "should get index"  do
  get :index if :admin_flag ==1
  assert_response :success
  end
end
