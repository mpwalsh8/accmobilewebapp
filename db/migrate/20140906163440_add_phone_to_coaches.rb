class AddPhoneToCoaches < ActiveRecord::Migration
  def change
    add_column :coaches, :phone, :string
  end
end
