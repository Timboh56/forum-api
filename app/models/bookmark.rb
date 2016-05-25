class Bookmark < ActiveRecord::Base
  include Base

  belongs_to :user
  belongs_to :bookmarkable, polymorphic: true
  after_create :increment_bookmarks_count
  validates_uniqueness_of :user_id, scope: :bookmarkable_id

  def increment_bookmarks_count
    if bookmarkable.try(:bookmarks_count)
      bookmarkable.increment!(:bookmarks_count)
    end
  end

  def question
    bookmarkable
  end

  def answer
    bookmarkable
  end
end
