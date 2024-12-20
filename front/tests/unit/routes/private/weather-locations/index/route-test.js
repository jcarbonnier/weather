import { module, test } from 'qunit';
import { setupTest } from 'front/tests/helpers';

module('Unit | Route | private/weather_locations/index', function (hooks) {
  setupTest(hooks);

  test('it exists', function (assert) {
    let route = this.owner.lookup('route:private/weather-locations/index');
    assert.ok(route);
  });
});
