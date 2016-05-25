class AddActivityCountToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :activity_count, :integer, default: 0
  end
end
