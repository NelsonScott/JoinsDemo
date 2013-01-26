class Comment < ActiveRecord::Base
  [ :body,
    :author_id,
    :post_id,
    :parent_comment_id ].each { |field| attr_accessible field }

  belongs_to :author, :class_name => "User"
  belongs_to :post
  belongs_to :parent, :class_name => "Comment", :foreign_key => "parent_comment_id"
end
