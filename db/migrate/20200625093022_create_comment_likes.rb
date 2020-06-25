class CreateCommentLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :comment_likes do |t|
      t.integer :user_id
      t.integer :board_comment_id

      t.timestamps
    end
  end
end
