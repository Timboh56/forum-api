class TagSerializer < BaseSerializer
  attributes :text, :taggings_count
  has_many :taggings
end
