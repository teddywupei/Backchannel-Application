require 'test_helper'
require 'test/unit'

class UsersControllerTest < ActionController::TestCase
  setup do
    @input_attributes = {
        :name                  => "name3",
        :password              => "name3",
        :password_confirmation => "name3",
        :admin_flag            => "1"
    }

    @user = users(:one)
  end

  test "admin should get index" do
    get :index if :admin_flag == 1
    assert_response :success

  end

  test "should show user" do
    get :show, id: @user
    assert_response :success
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "admin should get edit" do
      get :edit if :admin_flag==1
      assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post :create, :user=> @input_attributes
    end

    assert_redirected_to posts_path
  end

  test "should update user" do
    put :update, :id => @user.to_param, :user => @input_attributes
    assert_redirected_to user_path
  end
end

