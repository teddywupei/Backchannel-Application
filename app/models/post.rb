class Post < ActiveRecord::Base
  attr_accessible :category_id, :comments, :creator_id, :message, :modified_date, :modified_time, :id

  belongs_to :category
  has_many :comments
  has_many :post_votes

  validates :category, :presence => true
  validates :message, :presence => true

  def self.search(search)
    if search != nil
      search_condition = "%" + search + "%"
    else
      search_condition = "%%"
    end
    find(:all, :conditions => ['message LIKE ?', search_condition])
  end

end
