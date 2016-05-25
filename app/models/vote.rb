class Vote < ActiveRecord::Base
  include Base
  belongs_to :votable, polymorphic: true
  belongs_to :user
  after_create :update_votes_count
  after_create :update_activity_count

  after_destroy :update_votes_count
  validates_uniqueness_of :user_id, scope: :votable_id

  def update_activity_count
    votable.increment!(:activity_count) if votable.try(:activity_count)
  end

  def update_votes_count
    if votable
      votable.votes_count = votable.votes.count
      votable.save!
    end

    if votable.try(:question)
      votable.question.increment!(:votes_count)
    end
  end
end
