class CreateJoinTableUsersWeatherLocations < ActiveRecord::Migration[7.1]
  def change
    create_join_table :users, :weather_locations do |t|
      t.index %i[user_id weather_location_id]
    end
  end
end
