class Comment < ActiveRecord::Base
  [ :body,
    :author_id,
    :post_id,
    :parent_comment_id ].each { |field| attr_accessible field }

  [ :body,
    :author_id,
    :post_id ].each { |field| validates field, :presence => true }

  belongs_to :author, :class_name => "User"
  belongs_to :post
  belongs_to :parent, :class_name => "Comment", :foreign_key => "parent_comment_id"

  def self.reply_to_post(post, user, body)
    Comment.create!(
      :body => body,
      :author_id => user.id,
      :post_id => post.id,
      :parent_comment_id => nil)
  end

  def self.reply_to_comment(comment, user, body)
    Comment.create!(
      :body => body,
      :author_id => user.id,
      :post_id => comment.post_id,
      :parent_comment_id => comment.id)
  end
end
