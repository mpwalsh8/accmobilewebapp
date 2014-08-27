class RemoveEventDateTimeFromEvents < ActiveRecord::Migration
  def change
    remove_column :events, :eventdatetime, :string
  end
end
