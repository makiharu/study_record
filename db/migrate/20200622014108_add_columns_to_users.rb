class AddColumnsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :is_deleted, :boolean, default: false
    add_column :users, :profile_image_id, :string
  end
end
