class CreateBoardComments < ActiveRecord::Migration[5.2]
  def change
    create_table :board_comments do |t|
      t.integer :user_id
      t.integer :board_id
      t.string :comment

      t.timestamps
    end
  end
end
