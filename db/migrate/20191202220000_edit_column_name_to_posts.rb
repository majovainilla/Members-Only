class EditColumnNameToPosts < ActiveRecord::Migration[6.0]
  def change
    rename_column :posts, :user_id_id, :user_id
  end
end
