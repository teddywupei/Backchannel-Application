class Comment < ActiveRecord::Base
  attr_accessible :content, :post_id, :post_content, :creator_id

  belongs_to :post
  has_many :comment_votes

  validate :post, :presence => true
  validate :content, :presence => true
end
