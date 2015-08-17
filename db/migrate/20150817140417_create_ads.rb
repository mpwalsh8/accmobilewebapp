class CreateAds < ActiveRecord::Migration
  def change
    create_table :ads do |t|
      t.string :name
      t.string :imageurl
      t.string :clickurl
      t.string :adtype
      t.boolean :active

      t.timestamps null: false
    end
  end
end
