class AddIndexToComments < ActiveRecord::Migration
  def change
    add_index :comments, :text
  end
end
