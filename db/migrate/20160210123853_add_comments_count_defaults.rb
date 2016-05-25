class AddCommentsCountDefaults < ActiveRecord::Migration
  def change
     change_column_default :answers, :comments_count, 0
     change_column_default :questions, :comments_count, 0
  end
end
