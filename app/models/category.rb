class Category < ActiveRecord::Base
  attr_accessible :name
  has_many :posts
  validates :name, :presence => true

  def self.search(search)
    if search != nil
      search_condition = "%" + search + "%"
    else
      search_condition = "%%"
    end
    find(:all, :conditions => ['name LIKE ?', search_condition])
  end
end
