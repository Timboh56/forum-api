class CreateTaggings < ActiveRecord::Migration
  def change
    create_table :taggings do |t|
      t.references :taggable, polymorphic: true
      t.references :tag
      t.timestamps null: false
    end

    add_index :taggings, :taggable_id
    add_index :taggings, :taggable_type
    add_index :taggings, :tag_id
  end
end
