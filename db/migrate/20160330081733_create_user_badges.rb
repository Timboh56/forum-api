class CreateUserBadges < ActiveRecord::Migration
  def change
    create_table :user_badges do |t|
      t.references :user
      t.references :badge
      t.timestamps null: false
    end
  end
end