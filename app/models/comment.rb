class Comment < ActiveRecord::Base
  [ :body,
    :author_id,
    :post_id,
    :parent_comment_id ].each { |field| attr_accessible field }

  [ :body,
    :author_id,
    :post_id ].each { |field| validates field, :presence => true }

  # Rails would look for an `authors` table if we didn't tell it that
  # `author_id` refers to a `User`.
  belongs_to :author, :class_name => "User"
  belongs_to :post
  # Rails would look for `parent_id`, if we didn't give it the foreign
  # key name explicitly. Reminder: a *foreign key* is a database
  # column whose entries are primary keys (ids) in another table.
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
