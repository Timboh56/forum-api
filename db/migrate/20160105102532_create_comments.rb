class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :commentable, polymorphic: true
      t.references :user
      t.string :text
      t.timestamps null: false
    end

    add_index :comments, :user_id
    add_index :comments, :commentable_id
  end
end
