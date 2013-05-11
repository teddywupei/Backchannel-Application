require 'test_helper'

class CommentVotesControllerTest < ActionController::TestCase
  setup do
    @comment_vote = comment_votes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:comment_votes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should show comment_vote" do
    get :show, id: @comment_vote
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @comment_vote
    assert_response :success
  end

  test "should update comment_vote" do
    put :update, id: @comment_vote, comment_vote: { comment_id: @comment_vote.comment_id, voter_id: @comment_vote.voter_id }
    assert_redirected_to comment_vote_path(assigns(:comment_vote))
  end

  end