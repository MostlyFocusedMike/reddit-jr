class User < ApplicationRecord
  has_many :posts
  has_many :comments
  has_many :commented_posts, :through => :comments, :source => :post
  has_secure_password
  validates :username, :email, presence: true
  validates :username, uniqueness: { case_sensitive: false }
  validates :email, uniqueness: { case_sensitive: false }
  validates_confirmation_of :password

  def num_posts 
    self.posts.count > 0 ? "written #{self.posts.count}" : "not written any"
  end 

end
