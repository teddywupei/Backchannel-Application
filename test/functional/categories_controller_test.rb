require 'test_helper'

class CategoriesControllerTest < ActionController::TestCase
  setup do
    @category = categories(:one)  if :admin_flag == 1
  end

  test "should get index" do
    get :index  if :admin_flag == 1
    assert_response :success
  end

  test "should show category" do
    get :show, id: @category  if :admin_flag == 1
    assert_response :success
  end
  test "should get new" do
    get :new  if :admin_flag == 1
    assert_response :success
  end


  end





