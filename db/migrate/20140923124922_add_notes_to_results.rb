class AddNotesToResults < ActiveRecord::Migration
  def change
    add_column :results, :notes, :string
  end
end
