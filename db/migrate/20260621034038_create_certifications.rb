class CreateCertifications < ActiveRecord::Migration[8.1]
  def change
    create_table :certifications do |t|
      t.string :title
      t.string :slug
      t.text :description
      t.string :duration
      t.string :modality
      t.decimal :price
      t.date :start_date
      t.boolean :status
      t.string :category
      t.text :syllabus
      t.integer :seats_available

      t.timestamps
    end
  end
end
