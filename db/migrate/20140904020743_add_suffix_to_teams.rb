class AddSuffixToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :suffix, :string
  end
end
