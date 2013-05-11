require 'test_helper'

class PostTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "post attributes must not be empty" do
    post = Post.new
    assert post.invalid?
    assert post.errors[:creator_id].any?
    assert post.errors[:modified_date].any?
    assert post.errors[:message].any?
    assert post.errors[:category].any?
  end
end
