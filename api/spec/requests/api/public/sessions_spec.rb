# rubocop:disable RSpec/EmptyExampleGroup
require 'swagger_helper'

RSpec.describe 'Api::Public::Sessions', type: :request do
  path '/api/sessions' do
    post('signin user') do
      tags        'Public'
      description 'Signin a user'
      consumes    'application/vnd.api+json'
      produces    'application/vnd.api+json'
      security    []
      description <<~DESC
        <b>Signin</b>

        User signin
      DESC

      let(:target_user) { create(:user) }

      parameter name: :user, in: :body, required: true,
                description: 'Attributes login password are required.',
                schema: { type:       :json,
                          example:    Swagger::Schemas::Session::WRITE_EXAMPLE,
                          properties: Swagger::Schemas::Session::CREATE_ATTRIBUTES,
                          required:   %w[user] }

      response 201, 'User signed in' do
        schema(Swagger::Schemas::Session::SINGLE_ANSWER)
        let(:user) do
          { user: { login: target_user.login, password: target_user.password } }
        end
        run_test!
      end

      response 422, 'Invalid attribute' do
        schema({ '$ref' => '#/components/schemas/ValidationError' })
        let(:user) do
          { user: { login: 'test', password: 'test' } }
        end
        run_test!
      end
    end
  end
end
# rubocop:enable RSpec/EmptyExampleGroup
