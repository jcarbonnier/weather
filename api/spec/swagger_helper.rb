# frozen_string_literal: true

require 'rails_helper'

RSpec.configure do |config|
  # Specify a root folder where Swagger JSON files are generated
  # NOTE: If you're using the rswag-api to serve API descriptions, you'll need
  # to ensure that it's configured to serve Swagger from the same folder
  config.openapi_root = Rails.root.join('swagger').to_s

  # Define one or more Swagger documents and provide global metadata for each one
  # When you run the 'rswag:specs:swaggerize' rake task, the complete Swagger will
  # be generated at the provided relative path under openapi_root
  # By default, the operations defined in spec files are added to the first
  # document below. You can override this behavior by adding a openapi_spec tag to the
  # the root example_group in your specs, e.g. describe '...', openapi_spec: 'v2/swagger.json'
  config.openapi_specs = {
    'swagger.yaml' => {
      openapi:    '3.0.1',
      info:       {
        title:   'API appointment',
        version: 'v1'
      },
      paths:      {},
      servers:    [
        {
          url:       'https://{defaultHost}',
          variables: {
            defaultHost: {
              default: 'www.example.com'
            }
          }
        }
      ],
      components: {
        securitySchemes: {
          bearer_auth: {
            type:         :http,
            scheme:       :bearer,
            bearerFormat: :JWT
          }
        },
        schemas:         {
          ValidationError:      {
            type:        :object,
            properties:  {
              errors: { type:  :array,
                        items: { type:       :object,
                                 properties: {
                                   detail: { type: :string },
                                   source: { type:       :object,
                                             properties: {
                                               pointer: { type: :string }
                                             } }
                                 } } }
            },
            description: 'Required body parameters not found or invalid',
            example:     {
              errors: [
                { source: { pointer: '/data/attributes/name' },
                  detail: 'doit être rempli(e)' }
              ]
            }
          },
          CollectionAnswerMeta: {
            type:       :object,
            properties: {
              total:     { type: :integer, example: 100, description: 'Total number of results.' },
              page:      { type: :integer, example: 5, description: 'Current page for paginated result.' },
              page_size: { type: :integer, example: 10, description: 'Result number per page.' },
              pages:     { type: :integer, example: 10, description: 'Total number of pages.' },
              sort:      { type: :string, example: 'id', description: 'Current results sorting.' },
              direction: { type: :string, example: 'asc', description: 'Current results sorting direction.' }
            },
            required:   %w[total page page_size pages sort direction]
          }
        }
      }
    }
  }

  # Specify the format of the output Swagger file when running 'rswag:specs:swaggerize'.
  # The openapi_specs configuration option has the filename including format in
  # the key, this may want to be changed to avoid putting yaml in json files.
  # Defaults to json. Accepts ':json' and ':yaml'.
  config.openapi_format = :yaml
end
