class CreateLabelLists < ActiveRecord::Migration[5.2]
  def change
    create_table :label_lists do |t|
      t.integer :todolist_id
      t.integer :label_id

      t.timestamps
    end
  end
end
