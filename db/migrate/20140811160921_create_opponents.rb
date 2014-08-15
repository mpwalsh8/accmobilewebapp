class CreateOpponents < ActiveRecord::Migration
  def change
    create_table :opponents do |t|
      t.string :name
      t.string :mascot
      t.integer :homevenue
      t.boolean :conferenceopponent

      t.timestamps
    end
  end
end
