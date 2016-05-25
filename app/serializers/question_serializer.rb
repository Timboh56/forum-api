class QuestionSerializer <  CommentableSerializer
  attributes :id, :view_count, :bookmarks_count, :activity_count, :tag_words, :comments_count, :answers_count, :votes_count, :last_answerer_username, :created_at, :current_user_bookmark_id, :has_bookmarked, :comments, :text, :tags, :user, :updated_at, :user_id, :question_username, :created_at, :title
  belongs_to :user, serializer: UserSerializer
  has_many :taggings, as: :taggable, serializer: TaggingSerializer
  has_many :bookmarks, polymorphic: true, serializer: BookmarkSerializer
  has_many :answers, serializer: AnswerSerializer
  has_many :votes, serializer: VoteSerializer

  def answers
    object.answers.limit(20)
  end

  def tag_words
    object.tags.map { |tag| tag.text }.join(' ')
  end

  def current_user_bookmark_id
    scope.current_user.users_bookmark(object).id rescue nil
  end

  def question_username
    object.user.username rescue 'No user'
  end

  def has_bookmarked
    scope.current_user.has_bookmarked?(object)
  end
end
