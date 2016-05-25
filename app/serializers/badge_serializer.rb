class BadgeSerializer < BaseSerializer
  attributes :id, :color_hex, :name, :rank, :required_points
  has_many :user_badges
end
