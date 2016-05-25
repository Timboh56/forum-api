class CreateOrganizations < ActiveRecord::Migration
  def change
    create_table :organizations do |t|
      t.text :name
      t.timestamps null: false
    end
    add_index :organizations, :name
    add_index :organizations, :created_at
  end
end
