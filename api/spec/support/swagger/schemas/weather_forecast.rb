module Swagger
  module Schemas
    module WeatherForecast
      ALL_ATTRIBUTES = {
        id:           { type:        :integer,
                        nullable:    false,
                        description: 'WeatherForecast identifier.',
                        example:     1 },
        current_date: { type:        :date,
                        nullable:    true,
                        description: 'WeatherForecast date',
                        example:     '2024-01-01' },
        current:      { type:        :object,
                        nullable:    true,
                        description: 'WeatherForecast current' },
        forecast:     { type:        :object,
                        nullable:    true,
                        description: 'WeatherForecast',
                        example:     'France' }
      }.freeze

      ALL_RELATIONSHIPS = {
        weather_location: { type:        :object,
                            description: 'Location.',
                            example:     { data: { id: '1', type: 'weather_locations' } } }
      }.freeze

      RELATIONSHIPS = {
        type:       :object,
        properties: ALL_RELATIONSHIPS
      }.freeze

      READ_ATTRIBUTES = {
        type:       :object,
        properties: ALL_ATTRIBUTES.except(:id),
        required:   %w[current_date current forecast]
      }.freeze

      SERIALIZED = {
        type:       :object,
        properties: {
          id:            { type: :string, example: '1' },
          type:          { type: :string, example: 'weather_forecasts' },
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
    end
  end
end
