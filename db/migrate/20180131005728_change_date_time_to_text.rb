class ChangeDateTimeToText < ActiveRecord::Migration[5.1]
  def change
    change_column :events, :date, :text
    change_column :events, :time, :text
  end
end
