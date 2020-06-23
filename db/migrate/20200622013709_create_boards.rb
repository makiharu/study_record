class CreateBoards < ActiveRecord::Migration[5.2]
  def change
    create_table :boards do |t|
      t.integer :user_id
      t.string :title
      t.string :subject
      t.text :body
      t.string :image_id
      t.boolean :display, default: true

      t.timestamps
    end
  end
end
