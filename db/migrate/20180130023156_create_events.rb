class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.text :name, null: false
      t.date :date, null: false
      t.time :time, null: false
      t.text :location, null: false
      t.text :summary, null: false
      t.text :details, null: false
      t.text :organizer, null: false

      t.timestamps
    end

    add_index :events, :name, unique: true
  end
end
