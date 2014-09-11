class AddResultTypeToSports < ActiveRecord::Migration
  def change
    add_column :sports, :resulttype, :string
  end
end
