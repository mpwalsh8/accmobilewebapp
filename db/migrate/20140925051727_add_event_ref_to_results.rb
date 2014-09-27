class AddEventRefToResults < ActiveRecord::Migration
  def change
    add_reference :results, :event, index: true
  end
end
