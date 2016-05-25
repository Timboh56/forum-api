class AddOrganizationsReferences < ActiveRecord::Migration
  def change
    add_reference :users, :organization
  end
end
