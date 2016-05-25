class CreateBookmarks < ActiveRecord::Migration
  def change
    create_table :bookmarks do |t|
      t.references :user
      t.references :bookmarkable, polymorphic: true
      t.timestamps null: false
    end
    add_index :bookmarks, :user_id
    add_index :bookmarks, :bookmarkable_id
  end
end
