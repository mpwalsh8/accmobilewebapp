class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :name
      t.boolean :active
      t.string :url
      t.string :twitter
      t.string :gender
      t.boolean :varsity
      t.string :season
      t.integer :sport_id

      t.timestamps
    end
  end
end
