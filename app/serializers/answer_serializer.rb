class AnswerSerializer < CommentableSerializer
  attributes :id, :question_title, :current_user_vote_id, :has_voted, :text, :created_at, :answerer_username, :comments_count, :votes_count
  has_one :question, serializer: QuestionSerializer
  has_one :user, serializer: UserSerializer

  def answerer_username
    object.user.username rescue 'No user'
  end

  def question_title
    object.question.title
  end

  def current_user_vote_id
    scope.current_user.users_vote(object).id rescue nil
  end

  def has_voted
    scope.current_user.has_voted?(object)
  end
end
