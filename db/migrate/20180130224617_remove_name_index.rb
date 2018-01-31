class RemoveNameIndex < ActiveRecord::Migration[5.1]
  def change
    remove_index :events, :name
  end
end
