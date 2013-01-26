class User < ActiveRecord::Base
  [ :user_name,
    :first_name,
    :last_name ].each do |field|
    attr_accessible field
    validates field, :presence => true
  end

  has_many :posts, :foreign_key => :author_id
  has_many :comments, :foreign_key => :author_id
end
