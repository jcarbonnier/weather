import { module, test } from 'qunit';
import { setupRenderingTest } from 'front/tests/helpers';
import { render } from '@ember/test-helpers';
import { hbs } from 'ember-cli-htmlbars';

module('Integration | Component | gui/application/sidenav', function (hooks) {
  setupRenderingTest(hooks);

  test('it renders', async function (assert) {
    // Set any properties with this.set('myProperty', 'value');
    // Handle any actions with this.set('myAction', function(val) { ... });

    await render(hbs`<Gui::Application::Sidenav />`);

    assert.dom().hasText('');

    // Template block usage:
    await render(hbs`
      <Gui::Application::Sidenav>
        template block text
      </Gui::Application::Sidenav>
    `);

    assert.dom().hasText('template block text');
  });
});
