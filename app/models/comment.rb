class Comment < ActiveRecord::Base
  [ :body,
    :author_id,
    :post_id,
    :parent_comment_id ].each do |field|
    attr_accessible field
    validates field, :presence => true
  end

  belongs_to :author, :class_name => "User"
  belongs_to :post
  belongs_to :parent, :class_name => "Comment", :foreign_key => "parent_comment_id"

  def self.reply_to(comment, user, body)
    Comment.create!(
      :body => body,
      :author_id => user.id,
      :post_id => comment.post_id,
      :parent_comment_id => comment.id)
  end
end
