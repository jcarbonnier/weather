class CreateWeatherLocations < ActiveRecord::Migration[7.1]
  def change
    create_table :weather_locations do |t|
      t.string :name
      t.string :region
      t.string :country
      t.decimal :lat
      t.decimal :lon

      t.timestamps
    end
    add_index :weather_locations, %i[lat lon], name: 'index_lat_lon'
    add_index :weather_locations, :name
  end
end
