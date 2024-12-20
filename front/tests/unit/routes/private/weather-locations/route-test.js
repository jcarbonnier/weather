import { module, test } from 'qunit';
import { setupTest } from 'front/tests/helpers';

module('Unit | Route | private/weather_locations', function (hooks) {
  setupTest(hooks);

  test('it exists', function (assert) {
    let route = this.owner.lookup('route:private/weather-locations');
    assert.ok(route);
  });
});
