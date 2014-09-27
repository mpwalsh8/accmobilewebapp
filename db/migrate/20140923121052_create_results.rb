class CreateResults < ActiveRecord::Migration
  def change
    create_table :results do |t|
      t.integer :eventid
      t.string :result
      t.integer :place
      t.float :teamscore
      t.float :opponentscore

      t.timestamps
    end
  end
end
