class RemoveEventIdFromResults < ActiveRecord::Migration
  def change
    remove_column :results, :eventid, :integer
  end
end
