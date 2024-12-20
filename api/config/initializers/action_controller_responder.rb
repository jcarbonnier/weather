# frozen_string_literal: true

# Override action controller responder to match JSONAPI errors
module ActionController
  class Responder
    def jsonapi_resource_errors
      serializable_resource = ActiveModelSerializers::SerializableResource.new(
        resource,
        serializer: ActiveModel::Serializer::ErrorSerializer,
        adapter:    :json_api
      )
      serializable_resource.as_json(options)
    end
  end
end
