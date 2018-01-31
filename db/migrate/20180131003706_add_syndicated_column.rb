class AddSyndicatedColumn < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :syndicated, :boolean
  end
end
