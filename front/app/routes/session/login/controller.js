import Controller from '@ember/controller';

import { inject as service } from '@ember/service';
import { action } from '@ember/object';
import { tracked } from '@glimmer/tracking';

import * as Notify from 'front/services/notify';

export default class SessionLoginController extends Controller {
  // --------------------------------------------------
  // SERVICES
  // --------------------------------------------------
  @service session;
  @service store;
  @service notify;
  @service intl;

  // --------------------------------------------------
  // ATTRIBUTES AND METHODS
  // --------------------------------------------------
  @tracked errorMessage = '';
  @tracked loginMode = true;

  // --------------------------------------------------
  // ACTIONS
  // --------------------------------------------------
  @action
  toggleMode(e) {
    e.preventDefault();
    this.loginMode = !this.loginMode;
  }

  @action
  async signin(login, password, event) {
    event.preventDefault();
    // Authenticate
    try {
      console.log('Authenticate', window.location.hash);
      this.errorMessage = '';
      await this.session.authenticate('authenticator:custom', login, password);
    } catch (reason) {
      console.log('Authentication failure', reason);
      this.errorMessage = 'Echec de connexion';
      this.notify.toast(
        this.intl.t('notifications.failure.signin'),
        Notify.ERROR,
      );
    }
  }

  @action
  register(login, password, passwordConfirmation, event) {
    event.preventDefault();
    console.log('Register ', login, password, passwordConfirmation);
    this.model.user.setProperties({
      login: login,
      password: password,
      passwordConfirmation: passwordConfirmation,
    });
    this.model.user
      .save()
      .then((item) => {
        this.notify.toast(
          this.intl.t('notifications.success.saved'),
          Notify.SUCCESS,
        );
        return item;
      })
      .then((item) => {
        setTimeout(() => {
          this.signin(item.login, item.password, event);
        }, 500);
      })
      .catch((reason) => {
        console.error(
          '[PrivateInterventionsFormController] save error',
          reason,
        );
        this.notify.toast(
          this.intl.t('notifications.failure.saved'),
          Notify.ERROR,
        );
      });
  }
}
