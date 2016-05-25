class UserBadgeSerializer < BaseSerializer
  belongs_to :user
  belongs_to :badge
end
