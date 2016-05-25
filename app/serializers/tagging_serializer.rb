class TaggingSerializer < BaseSerializer
  attribute :id
  belongs_to :tag
  belongs_to :taggable,  polymorphic: true
end