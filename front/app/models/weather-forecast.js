import Model, { attr, belongsTo } from '@ember-data/model';

export default class WeatherForecastModel extends Model {
  // --------------------------------------------------
  // Relationships
  // --------------------------------------------------
  @belongsTo('weather-location', {
    async: true,
    inverse: 'weatherForecasts',
  })
  weatherLocation;

  // --------------------------------------------------
  // Attributes
  // --------------------------------------------------
  // @attr('moment-date') currentDate;
  @attr('date') currentDate;
  @attr current;
  @attr forecast;
}
