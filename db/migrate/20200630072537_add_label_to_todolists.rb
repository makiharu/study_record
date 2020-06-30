class AddLabelToTodolists < ActiveRecord::Migration[5.2]
  def change
    add_column :todolists, :label, :string
  end
end
