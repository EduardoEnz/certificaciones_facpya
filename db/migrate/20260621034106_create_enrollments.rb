class CreateEnrollments < ActiveRecord::Migration[8.1]
  def change
    create_table :enrollments do |t|
      t.references :lead, null: false, foreign_key: true
      t.references :certification, null: false, foreign_key: true
      t.string :status

      t.timestamps
    end
  end
end
