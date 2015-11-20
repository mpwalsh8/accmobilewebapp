class CreateSugs < ActiveRecord::Migration
  def change
    create_table :sugs do |t|
      t.string :name
      t.string :description
      t.string :sugurl
      t.boolean :active

      t.timestamps null: false
    end
  end
end
