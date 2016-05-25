class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.references :user
      t.references :votable, polymorphic: true
      t.timestamps null: false
    end
    add_index :votes, :user_id
    add_index :votes, :votable_id
    add_index :votes, :votable_type
  end
end
