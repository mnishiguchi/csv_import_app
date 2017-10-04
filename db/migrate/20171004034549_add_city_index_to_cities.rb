class AddCityIndexToCities < ActiveRecord::Migration[5.1]
  def change
    add_index :cities, :city, unique: true
  end
end
