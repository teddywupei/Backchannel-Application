class PostVote < ActiveRecord::Base
  attr_accessible :post_id, :voter_id

  belongs_to :post
end
