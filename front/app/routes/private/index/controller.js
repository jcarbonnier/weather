import FilterResultsController from 'front/controllers/filter-results';

import { action } from '@ember/object';
import { inject as service } from '@ember/service';

import * as Notify from 'front/services/notify';

export default class PrivateIndexController extends FilterResultsController {
  // ==================================================
  // Services
  // ==================================================
  @service store;
  @service intl;
  @service notify;
  @service router;
  @service session;

  // ==================================================
  // Query params
  // ==================================================
  // name = '';

  // ==================================================
  // Actions
  // ==================================================
  @action
  bookmarkLocation(location) {
    console.log('Bookmark location', location);
    let record = this.store.createRecord('weather-location', {
      country: location.country,
      lat: location.lat,
      lon: location.lon,
      name: location.name,
      region: location.region,
    });
    record
      .save()
      .then((item) => {
        this.notify.toast(
          this.intl.t('notifications.success.saved'),
          Notify.SUCCESS,
        );
        this.name = '';
        return item;
      })
      .then((item) => {
        console.log('Add location to service', item);
        this.session.currentUser.reload();
      })
      .catch((reason) => {
        console.error('[PrivateIndexController] save error', reason);
        this.notify.toast(
          this.intl.t('notifications.failure.saved'),
          Notify.ERROR,
        );
      });
  }
}
