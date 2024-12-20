import { module, test } from 'qunit';
import { setupRenderingTest } from 'front/tests/helpers';
import { render } from '@ember/test-helpers';
import { hbs } from 'ember-cli-htmlbars';

module(
  'Integration | Component | form/input-floating-delayed',
  function (hooks) {
    setupRenderingTest(hooks);

    test('it renders', async function (assert) {
      // Set any properties with this.set('myProperty', 'value');
      // Handle any actions with this.set('myAction', function(val) { ... });

      await render(hbs`<Form::InputFloatingDelayed />`);

      assert.dom().hasText('');

      // Template block usage:
      await render(hbs`
      <Form::InputFloatingDelayed>
        template block text
      </Form::InputFloatingDelayed>
    `);

      assert.dom().hasText('template block text');
    });
  },
);
