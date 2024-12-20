import Model, { attr, hasMany } from '@ember-data/model';

export default class UserModel extends Model {
  // --------------------------------------------------
  // Relationships
  // --------------------------------------------------
  @hasMany('weather-location', {
    async: true,
    inverse: 'users',
  })
  weatherLocations;

  // --------------------------------------------------
  // Attributes
  // --------------------------------------------------
  @attr('string') login;
  @attr('string') password;
  @attr('string') passwordConfirmation;
}
