class AddOpponentsToEvents < ActiveRecord::Migration
  def change
    add_column :events, :opponents, :string
  end
end
