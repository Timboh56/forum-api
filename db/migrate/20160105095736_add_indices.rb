class AddIndices < ActiveRecord::Migration
  def change
    add_index :questions, :user_id
    add_index :questions, :text
    add_index :answers, :text
    add_index :questions, :title
    add_index :answers, :user_id
  end
end
