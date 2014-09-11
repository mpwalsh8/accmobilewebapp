class AddTeamPictureUrlToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :teampicurl, :string
  end
end
