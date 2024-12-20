import Route from '@ember/routing/route';

import { hash } from 'rsvp';
import { inject as service } from '@ember/service';

export default class PrivateWeatherLocationsShowRoute extends Route {
  // ==================================================
  // SERVICES
  // ==================================================
  @service store;
  @service router;

  // ==================================================
  // HANDLERS
  // ==================================================
  model(params) {
    return hash({
      location: this.store.findRecord('weather-location', params.id),
      forecasts: this.store.query('weather-forecast', {
        filter: { weather_location_id: params.id, current_date: Date.today }
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
