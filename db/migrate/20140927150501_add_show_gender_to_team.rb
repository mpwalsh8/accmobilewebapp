class AddShowGenderToTeam < ActiveRecord::Migration
  def change
    add_column :teams, :showgender, :boolean
  end
end
