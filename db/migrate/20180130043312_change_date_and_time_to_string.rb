class ChangeDateAndTimeToString < ActiveRecord::Migration[5.1]
  def change
    change_column :events, :date, :string
    change_column :events, :time, :string
  end
end
