class CommentSerializer < BaseSerializer
  attributes :question, :answer, :id, :text, :user_id, :anonymous, :author_user_name, :commentable_id, :commentable_type, :created_at
  has_one :user

  def author_user_name
    object.user.username
  end

  def self.extract_serializer_from_id_field(rel)
    klass_name = rel.to_s.match('_id') ? strip_id_field(rel) : rel.to_s
    (klass_name.capitalize).constantize
  end

  def self.strip_id_field(rel)
    rel.to_s.gsub('_id','')
  end

  def question
    return object.commentable || nil
  end

  def answer
    return object.commentable || nil
  end
end
