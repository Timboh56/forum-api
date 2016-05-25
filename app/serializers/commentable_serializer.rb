class CommentableSerializer < BaseSerializer
  attribute :comments_count

  #has_many :comments, polymorphic: :true, serializer: CommentSerializer

  #def comments
  #  Comment.limit(30)
  #end
end