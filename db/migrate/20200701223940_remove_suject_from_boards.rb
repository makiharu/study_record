class RemoveSujectFromBoards < ActiveRecord::Migration[5.2]
  def change
    remove_column :boards, :subject, :string
  end
end
