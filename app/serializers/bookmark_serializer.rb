class BookmarkSerializer < ActiveModel::Serializer
  attributes :id, :bookmarkable_id, :bookmarkable_type, :user_id
  belongs_to :user
  belongs_to :question, as: :bookmarkable, polymorphic: true, serializer: QuestionSerializer
end