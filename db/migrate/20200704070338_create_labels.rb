class CreateLabels < ActiveRecord::Migration[5.2]
  def change
    create_table :labels do |t|
      t.integer :label_id
      t.string :name
      t.boolean :is_void, default: false

      t.timestamps
    end
  end
end
