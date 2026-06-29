class AddStatusToRegistrations < ActiveRecord::Migration[8.1]
  def change
    add_column :registrations, :status, :string
  end
end
