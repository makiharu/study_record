class CreateTodolists < ActiveRecord::Migration[5.2]
  def change
    create_table :todolists do |t|
      t.integer :user_id
      t.string :content
      t.integer :time_category, default: 0
      t.boolean :done, default: 0
      t.datetime :update_date, default: -> { 'CURRENT_TIMESTAMP' }

      t.timestamps
    end
  end
end
