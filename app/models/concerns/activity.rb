module Activity
  extend ActiveSupport::Concern

  included do
    after_create :update_activity_count
  end

  def update_activity_count
    question.increment!(:activity_count)
  end
end
