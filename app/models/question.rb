class Question < ActiveRecord::Base
  include Base
  include Searchable
  include Taggable
  extend FriendlyId

  friendly_id :title
  paginates_per 20
  belongs_to :user
  has_many :answers, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :votes, as: :votable, dependent: :destroy
  has_many :bookmarks, as: :bookmarkable, dependent: :destroy

  def setTags!(tagWords)
    tagWords.split(" ").each do |tagWord|
      tag = Tag.where(text: tagWord).first_or_initialize
      self.tags << tag
      tag.save! if tag.new_record?
    end
    save!
  rescue StandardError => e
    p e.inspect
  end
end
