import Model, { attr, hasMany } from '@ember-data/model';

export default class WeatherLocationModel extends Model {
  // --------------------------------------------------
  // Relationships
  // --------------------------------------------------
  @hasMany('user', {
    async: true,
    inverse: 'weatherLocations',
  })
  users;

  @hasMany('weather-forecast', {
    async: true,
    inverse: 'weatherLocation',
  })
  weatherForecasts;

  // --------------------------------------------------
  // Attributes
  // --------------------------------------------------
  @attr('string') name;
  @attr('string') region;
  @attr('string') country;
  @attr('number') lat;
  @attr('number') lon;
  // @attr('moment-date') createdAt;

  get currentForecast() {
    console.log("Current fc: ", this.weatherForecasts);
    return this.weatherForecasts.firstObject;
  }
}
