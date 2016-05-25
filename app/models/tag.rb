class Tag < ActiveRecord::Base
  has_many :taggings
  has_many :questions, as: :taggable

end
