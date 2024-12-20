module Swagger
  module Schemas
    module Session
      ALL_ATTRIBUTES = {
        id:    { type:        :integer,
                 nullable:    false,
                 description: 'Session identifier.',
                 example:     1 },
        token: { type:        :string,
                 nullable:    true,
                 description: 'Session JWT token',
                 example:     'jwt' },
        login: { type:        :string,
                 nullable:    true,
                 description: 'Session login',
                 example:     'test' }
      }.freeze

      SERIALIZED = {
        type:       :object,
        properties: ALL_ATTRIBUTES,
        required:   %w[id login token]
      }.freeze

      SINGLE_ANSWER = SERIALIZED.freeze

      WRITE_EXAMPLE = {
        user: {
          login:    'test',
          password: 'pws'
        }
      }.freeze

      CREATE_ATTRIBUTES = {
        user: {
          type:       :object,
          properties: { user: SERIALIZED },
          required:   %w[login password]
        }
      }.freeze
    end
  end
end
