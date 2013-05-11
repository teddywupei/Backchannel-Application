class CommentVote < ActiveRecord::Base
  attr_accessible :comment_id, :voter_id

  belongs_to :comment

end
