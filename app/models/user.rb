class User < ActiveRecord::Base
  attr_accessible :user_name, :first_name, :last_name

  has_many :posts, :foreign_key => :author_id
  has_many :comments, :foreign_key => :author_id
end
