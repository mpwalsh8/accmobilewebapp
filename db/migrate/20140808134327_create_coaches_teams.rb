class CreateCoachesTeams < ActiveRecord::Migration
  def change
    create_table :coaches_teams do |t|
      t.integer :team_id
      t.integer :coach_id
      t.boolean :headcoach

      t.timestamps
    end

    #  Add an index
    add_index :coaches_teams, [:coach_id, :team_id], :unique => true
  end
end
