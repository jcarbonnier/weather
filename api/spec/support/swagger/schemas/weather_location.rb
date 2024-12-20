module Swagger
  module Schemas
    module WeatherLocation
      ALL_ATTRIBUTES = {
        id:      { type:        :integer,
                   nullable:    false,
                   description: 'WeatherLocation identifier.',
                   example:     1 },
        name:    { type:        :string,
                   nullable:    true,
                   description: 'WeatherLocation name',
                   example:     'Paris' },
        region:  { type:        :string,
                   nullable:    true,
                   description: 'WeatherLocation region',
                   example:     'Eure' },
        country: { type:        :string,
                   nullable:    true,
                   description: 'WeatherLocation country',
                   example:     'France' },
        lat:     { type:        :string,
                   nullable:    false,
                   description: 'WeatherLocation latitude',
                   example:     33.78 },
        lon:     { type:        :string,
                   nullable:    false,
                   description: 'WeatherLocation longitude',
                   example:     48.78 }
      }.freeze

      ALL_RELATIONSHIPS = {
        weather_forecasts: { type:        :object,
                             description: 'Forecasts.',
                             example:     { data: [{ id: '1', type: 'weather_forecasts' }] } },
        users:             { type:        :object,
                             description: 'Users.',
                             example:     { data: [{ id: '1', type: 'users' }] } }
      }.freeze

      RELATIONSHIPS = {
        type:       :object,
        properties: ALL_RELATIONSHIPS
      }.freeze

      READ_ATTRIBUTES = {
        type:       :object,
        properties: ALL_ATTRIBUTES.except(:id),
        required:   %w[name country lat lon]
      }.freeze

      SERIALIZED = {
        type:       :object,
        properties: {
          id:            { type: :string, example: '1' },
          type:          { type: :string, example: 'weather_locations' },
          attributes:    READ_ATTRIBUTES,
          relationships: RELATIONSHIPS
        },
        required:   %w[type attributes relationships]
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
        required:   %w[data]
      }.freeze

      SINGLE_ANSWER = {
        type:       :object,
        properties: { data: SERIALIZED },
        required:   %w[data]
      }.freeze

      WRITE_EXAMPLE = {
        data: {
          type:          'weather_locations',
          attributes:    {
            name:    'Paris',
            region:  'Ile-De-France',
            country: 'France',
            lat:     33.78,
            lon:     48.43
          },
          relationships: {
            company:      { data: { type: 'companies', id: '1' } },
            intervention: { data: { type: 'interventions', id: '1' } }
          }
        }
      }.freeze

      CREATE_ATTRIBUTES = {
        data: {
          type:       :object,
          properties: { data: SERIALIZED },
          required:   %w[name region country lat lon]
        }
      }.freeze

      # UPDATE_ATTRIBUTES = {
      #   data: { type:       :object,
      #           properties: { data: SERIALIZED },
      #           required:   %w[start_at company intervention] }
      # }.freeze
    end
  end
end
