class User < ActiveRecord::Base
  extend FriendlyId

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  #`after_create :create_api_key
  friendly_id :username
  has_one :api_key, dependent: :destroy
  has_one :user_stat, dependent: :destroy
  has_many :questions
  has_many :answers
  has_many :comments
  has_many :bookmarks
  has_many :votes
  has_many :user_badges
  has_many :badges, through: :user_badges

  def has_voted?(votable)
    users_vote(votable).present?
  end

  def has_bookmarked?(bookmarkable)
    users_bookmark(bookmarkable).present?
  end

  def users_bookmark(bookmarkable)
    bookmarks.find { |b| b.bookmarkable_id == bookmarkable.id}
  end

  def users_vote(votable)
    votes.find { |v| v.votable_id == votable.id }
  end
end
