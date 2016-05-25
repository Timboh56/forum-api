class Comment < ActiveRecord::Base
  include Base
  include Searchable
  belongs_to :commentable, polymorphic: true
  belongs_to :user
  after_create :update_comments_count

  def update_comments_count
    commentable.comments_count = commentable.comments_count + 1
    commentable.save!
  end

  def question
    commentable
  end

  def answer
    commentable
  end
end
