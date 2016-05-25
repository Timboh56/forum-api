class AddColorHexToBadges < ActiveRecord::Migration
  def change
    add_column :badges, :color_hex, :string
  end
end
