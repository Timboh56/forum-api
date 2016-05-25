class AddLastAnswererUsername < ActiveRecord::Migration
  def change
    add_column :questions, :last_answerer_username, :string
  end
end
