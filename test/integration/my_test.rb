require 'test_helper'
class MyTest < ActionDispatch::IntegrationTest
  test "login" do

    # login via https
    get "/session/new"
    assert_response :success


    post_via_redirect "/session", :users=>{:name => "boss",
                                           :password => "boss"}
    assert_response :success


  end
end
