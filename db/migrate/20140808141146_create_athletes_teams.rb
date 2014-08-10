class CreateAthletesTeams < ActiveRecord::Migration
  def change
    create_table :athletes_teams do |t|
      t.integer :athlete_id
      t.integer :team_id
      t.boolean :captain
      t.string :jerseynumber
      t.string :position

      t.timestamps
    end
  end
end
