import Route from '@ember/routing/route';

import { hash } from 'rsvp';
import { inject as service } from '@ember/service';

export default class PrivateWeatherLocationsShowRoute extends Route {
  // ==================================================
  // SERVICES
  // ==================================================
  @service store;
  @service router;
  @service moment;

  // ==================================================
  // HANDLERS
  // ==================================================
  model(params) {
    console.log("Moment", this.moment.moment().format('Y-M-D'));
    return hash({
      location: this.store.findRecord('weather-location', params.id),
      forecasts: this.store.query('weather-forecast', {
        filter: {
          current_date: this.moment.moment().format('Y-M-D'),
          weather_location_id: params.id,
        }
      }),
    });
  }

  setupController(controller, model, _transition) {
    super.setupController(controller, model);
    // Forecast
    if (model.forecasts.length > 0) {
      console.log("Fc:", model.forecasts[0].forecast.forecastday);
      controller.set('forecast', model.forecasts[0]);
    }
  }
}
