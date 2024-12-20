import Devise from 'ember-simple-auth/authenticators/devise';

export default class CustomAuthenticator extends Devise {
  // Setup
  serverTokenEndpoint = '/api/sessions';
  resourceName = 'user';
  tokenAttributeName = 'token';
  identificationAttributeName = 'login';
}
