class CreateCoaches < ActiveRecord::Migration
  def change
    create_table :coaches do |t|
      t.string :firstname
      t.string :middlename
      t.string :lastname
      t.string :nickname
      t.boolean :active
      t.string :email
      t.string :twitter

      t.timestamps
    end
  end
end
