class CreateEvents < ActiveRecord::Migration[8.1]
  def change
    create_table :events do |t|
      t.string :title
      t.integer :capacity
      t.datetime :start_date
      t.datetime :end_date

      t.timestamps
    end
  end
end
