require 'test_helper'

class PostVotesControllerTest < ActionController::TestCase
  setup do
    @post_vote = post_votes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:post_votes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end



  test "should show post_vote" do
    get :show, id: @post_vote
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @post_vote
    assert_response :success
  end


  end
