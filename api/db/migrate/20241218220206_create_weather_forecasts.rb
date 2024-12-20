class CreateWeatherForecasts < ActiveRecord::Migration[7.1]
  def change
    create_table :weather_forecasts do |t|
      t.integer :weather_location_id
      t.json :forecast
      t.json :current
      t.date :current_date

      t.timestamps
    end
    add_index :weather_forecasts, %i[weather_location_id current_date], name: 'index_location_and_date'
  end
end
