require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  setup do
    @users = users(:one)
  end
  test "should login" do
    post :create, :name => @users.name, :password => @users.password
    assert_redirected_to admin_url
    assert_equal @users.id, session[:user_id]
  end

  test "should fail login" do
    post :create, :name => @users.name, :password => 'wrong'
    assert_redirected_to new_session_url
  end


end