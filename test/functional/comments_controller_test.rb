require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
  setup do
    @comment = comments(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:comments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end



  test "should show comment" do
    get :show, id: @comment
    assert_response :success
  end



  test "should update comment" do
    put :update, id: @comment, comment: { content: @comment.content, post_id: @comment.post_id }
    assert_redirected_to comment_path
  end


  end


