class Badge < ActiveRecord::Base
  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
  validates_presence_of :color_hex
  validates_presence_of :name
  validates_presence_of :rank
  has_many :user_badges
end
