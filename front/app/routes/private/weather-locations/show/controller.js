import Controller from '@ember/controller';

import { inject as service } from '@ember/service';
import { action } from '@ember/object';

import * as Notify from 'front/services/notify';

export default class PrivateWeatherLocationsShowController extends Controller {
  // --------------------------------------------------
  // SERVICES
  // --------------------------------------------------
  @service router;
  @service notify;
  @service intl;

  // --------------------------------------------------
  // ACTIONS
  // --------------------------------------------------
  @action
  destroyBookmarkConfirmed(event) {
    event.preventDefault();
    this.model.location
      .destroyRecord()
      .then(() => {
        this.notify.toast(
          this.intl.t('notifications.success.deleted'),
          Notify.SUCCESS,
        );
        const modalElement = bootstrap.Modal.getOrCreateInstance('#modal');
        modalElement.hide();
      }).then(() => {
        setTimeout(() => {
          this.router.transitionTo('private.index');
        }, 500);
      })
      .catch((reason) => {
        console.error('[GuiApplicationSidenavComponent] destroy error', reason);
        this.notify.toast(
          this.intl.t('notifications.failure.deleted'),
          Notify.ERROR,
        );
      });
  }
}
