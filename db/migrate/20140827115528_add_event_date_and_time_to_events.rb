class AddEventDateAndTimeToEvents < ActiveRecord::Migration
  def change
    add_column :events, :eventdate, :string
    add_column :events, :eventtime, :string
  end
end
