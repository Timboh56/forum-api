class Answer < ActiveRecord::Base
  include Base
  include Searchable
  include Taggable
  include Activity

  belongs_to :question
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :votes, as: :votable, dependent: :destroy
  validates_presence_of :question
  validates_presence_of :user
  validates_uniqueness_of :user_id, scope: :question_id

  after_create :update_answers_count!
  after_destroy :update_answers_count!
  after_create :update_question_last_answerer_username!

  def update_question_last_answerer_username!
    question.last_answerer_username = user.username
    question.save!
  end

  def update_answers_count!
    question.answers_count = question.answers.count
    question.save!
  end
end
