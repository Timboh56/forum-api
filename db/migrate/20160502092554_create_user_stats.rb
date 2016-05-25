class CreateUserStats < ActiveRecord::Migration
  def change
    create_table :user_stats do |t|
      t.integer :activity_count, default: 0
      t.integer :login_attempts, default: 0
      t.integer :questions_count, default: 0
      t.references :user
      t.timestamps null: false
    end
    add_index :user_stats, :user_id
    add_index :user_stats, :activity_count
  end
end
