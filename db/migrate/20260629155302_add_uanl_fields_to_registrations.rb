class AddUanlFieldsToRegistrations < ActiveRecord::Migration[8.1]
  def change
    add_column :registrations, :is_uanl, :string
    add_column :registrations, :faculty, :string
  end
end
