module Swagger
  module Schemas
    module User
      ALL_ATTRIBUTES = {
        id:       { type:        :integer,
                    nullable:    false,
                    description: 'Company identifier.',
                    example:     1 },
        login:    { type:        :string,
                    nullable:    true,
                    description: 'User login',
                    example:     'test' },
        password: { type:        :string,
                    nullable:    true,
                    description: 'User password',
                    example:     'secret' }
      }.freeze

      ALL_RELATIONSHIPS = {
        weather_locations: { type:        :object,
                             description: 'Weather locations relationship.',
                             example:     { data: [{ id: '1', type: 'weather_locations' }] } }
      }.freeze

      RELATIONSHIPS = {
        type:       :object,
        properties: ALL_RELATIONSHIPS
      }.freeze

      READ_ATTRIBUTES = {
        type:       :object,
        properties: ALL_ATTRIBUTES.slice(:password),
        required:   %w[login]
      }.freeze

      SERIALIZED = {
        type:       :object,
        properties: {
          id:            { type: :string },
          type:          { type: :string, example: 'users' },
          attributes:    READ_ATTRIBUTES,
          relationships: RELATIONSHIPS
        },
        required:   %w[id type attributes relationships]
      }.freeze

      COLLECTION_ANSWER = {
        type:       :object,
        properties: {
          data: {
            type:  :array,
            items: SERIALIZED
          },
          meta: { '$ref' => '#/components/schemas/CollectionAnswerMeta' }
        },
        required:   %w[data meta]
      }.freeze

      SINGLE_ANSWER = {
        type:       :object,
        properties: { data: SERIALIZED },
        required:   %w[data]
      }.freeze

      WRITE_EXAMPLE = {
        data: {
          type:       'users',
          attributes: {
            login:                 'login',
            password:              'secret password',
            password_confirmation: 'secret password'
          }
        }
      }.freeze

      CREATE_ATTRIBUTES = {
        data: {
          type:       :object,
          properties: { data: SERIALIZED },
          required:   %w[login password password_confirmation]
        }
      }.freeze
    end
  end
end
