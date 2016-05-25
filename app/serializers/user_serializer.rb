class UserSerializer < BaseSerializer
  attributes :id, :created_at, :username, :questions_count_string
  has_many :questions, serializer: QuestionSerializer
  #has_many :comments, serializer: CommentSerializer
  has_many :answers, serializer: AnswerSerializer, include: true
  has_many :votes, serializer: VoteSerializer
  has_many :bookmarks, serializer: BookmarkSerializer
  has_many :user_badges, serializer: UserBadgeSerializer
  has_many :badges, througuh: :user_badges, serializer: BadgeSerializer

  def questions_count_string
    "#{ object.questions.count.to_s } questions"
  end

  def answers
    object.answers.limit(20)
  end

  def questions
    object.questions.limit(20)
  end

  [:answers, :questions, :votes].each do |model|
    define_method("include_#{ model.to_s }?") do
      object.association(model).loaded?
    end
  end
end
