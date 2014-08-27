class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :teamid
      t.integer :opponentid
      t.integer :venueid
      t.string :type
      t.datetime :eventdatetime
      t.integer :eventduration

      t.timestamps
    end
  end
end
