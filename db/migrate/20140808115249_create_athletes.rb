class CreateAthletes < ActiveRecord::Migration
  def change
    create_table :athletes do |t|
      t.string :firstname
      t.string :middlename
      t.string :lastname
      t.string :nickname
      t.date :dob
      t.integer :gradyear
      t.boolean :active
      t.float :height
      t.float :weight
      t.string :email
      t.string :twitter
      t.string :gender

      t.timestamps
    end
  end
end
