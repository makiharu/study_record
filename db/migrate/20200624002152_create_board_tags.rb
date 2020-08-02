class CreateBoardTags < ActiveRecord::Migration[5.2]
  def change
    create_table :board_tags do |t|
      t.integer :board_id
      t.integer :tag_id

      t.timestamps
    end
  end
end
