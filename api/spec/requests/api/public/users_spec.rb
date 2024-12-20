# rubocop:disable RSpec/EmptyExampleGroup
require 'swagger_helper'

RSpec.describe 'Api::Public::Users', type: :request do
  let(:weather_location) { create(:weather_location, user: user) }

  path '/api/users' do
    post('create user') do
      tags        'Public'
      description 'Create a user'
      consumes    'application/vnd.api+json'
      produces    'application/vnd.api+json'
      security    []
      description <<~DESC
        <b>Create user</b>

        Registering user
      DESC

      parameter name: :data, in: :body, required: true,
                description: 'Attributes login password password_confirmatoion are required.',
                schema: { type:       :json,
                          example:    Swagger::Schemas::User::WRITE_EXAMPLE,
                          properties: Swagger::Schemas::User::CREATE_ATTRIBUTES,
                          required:   %w[data] }

      response 201, 'User created' do
        schema(Swagger::Schemas::User::SINGLE_ANSWER)
        let(:data) do
          { data: { type:       'users',
                    attributes: attributes_for(:user) } }
        end
        run_test!
      end

      response 422, 'Invalid attribute' do
        schema({ '$ref' => '#/components/schemas/ValidationError' })
        let(:data) do
          { data: { type:       'users',
                    attributes: attributes_for(:user).delete(:login) } }
        end
        run_test!
      end
    end
  end
end
# rubocop:enable RSpec/EmptyExampleGroup
