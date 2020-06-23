class RenameBoardStatusColumnToboards < ActiveRecord::Migration[5.2]
  def change
  	rename_column :boards, :board_status, :display
  end
end
