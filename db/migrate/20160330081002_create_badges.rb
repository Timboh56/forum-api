class CreateBadges < ActiveRecord::Migration
  def change
    create_table :badges do |t|
      t.string :name
      t.integer :rank
      t.integer :required_points
      t.attachment :avatar
      t.timestamps null: false
    end
  end
end
