class CreateLeads < ActiveRecord::Migration[8.1]
  def change
    create_table :leads do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.string :student_id
      t.string :career
      t.text :notes
      t.string :status

      t.timestamps
    end
  end
end
