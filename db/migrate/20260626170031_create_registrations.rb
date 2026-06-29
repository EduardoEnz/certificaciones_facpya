class CreateRegistrations < ActiveRecord::Migration[8.1]
  def change
    create_table :registrations do |t|
      t.references :event, foreign_key: true
      t.string :role
      t.string :name
      t.string :email
      t.string :phone
      t.string :matricula
      t.string :career

      t.timestamps
    end
  end
end
