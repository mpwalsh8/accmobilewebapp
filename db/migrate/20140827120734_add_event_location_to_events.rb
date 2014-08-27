class AddEventLocationToEvents < ActiveRecord::Migration
  def change
    add_column :events, :eventlocation, :string
  end
end
