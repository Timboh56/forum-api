class Tagging < ActiveRecord::Base
  belongs_to :taggable, polymorphic: true
  belongs_to :tag
  after_create :update_taggings_count

  def update_taggings_count
    tag.increment!(:taggings_count) if tag
  end

  #shitty hackish
  def question
    taggable
  end
end
