module CommentsHelper

  def vote_link(comment)
    if comment.comment_votes.find_all_by_voter_id(session[:user_name]).empty?
      CommentVote.create(:comment_id => comment.id, :voter_id => session[:user_name])
      Post.find_by_id(comment.post_id).update_attribute('modified_date', Date.current )
      Post.find_by_id(comment.post_id).update_attribute('modified_time', Time.current )
    else
      flash.keep[:notice] = "Cannot vote twice for the same post or comment"
      warn("")
    end
  end

end
