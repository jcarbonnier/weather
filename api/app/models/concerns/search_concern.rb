# == Search active record concern
#
# Adding search class method to active records
module SearchConcern
  # ==================================================
  # Extends
  # ==================================================
  extend ActiveSupport::Concern

  # ==================================================
  # Class methods
  # ==================================================
  class_methods do
    # == Filtering method
    # Takes controller params[:filter] as input parameter
    # and uses "scope" to chain where / joins / order / limit
    # to return filtered, ordered, limited results for a
    # model class.
    #
    # It parses parameters that are not a model attributes
    # to take care about specific filter (ex: received_after
    # filter is recevied_at greater than the value). Otherwise,
    # it filter by the known attribute.
    def db_search(in_parameters = {})
      Rails.logger.info("[ActiveRecord::Base] override search parameters: #{in_parameters}")
      return all if in_parameters.blank?

      # Cleanup parameters
      parameters = cleanup_parameters(in_parameters)
      # Results
      results = where(nil)
      parameters.each_pair do |k, v|
        # Rails.logger.debug { "K:#{k}=#{v}" }
        k = k.to_s
        next if skip_key?(k)

        results = filter_results(results, k, v)
      end
      results = search_ordering(results, parameters) if parameters['sort'].present?
      results
    end

    # Check if key is skipable
    def skip_key?(key)
      %w[action controller access_token _ utf8 format columns page pageSize sort direction].include?(key)
    end

    # Filter results
    def filter_results(results, key, value)
      case key
      when 'filter'
        db_search(value)
      when 'id', 'ids', 'weather_location_id'
        filter_by_id(results, key, value)
      when 'enabled'
        filter_by_boolean(results, key, value)
      when 'current_date'
        filter_by_exact_value(results, key, value)
      else
        filter_by_value(results, key, value)
      end
    end

    # Cleanup nlank or not needed parameters
    def cleanup_parameters(in_parameters)
      in_parameters.delete_if do |_key, v|
        (v.instance_of?(Array) && (v - ['']).empty?) || v.blank?
      end
    end

    # Search results by id or ids
    def filter_by_id(results, key, value)
      key = 'id' if key == 'ids'
      ids = value.is_a?(String) ? value.split(',') : value
      results.where("#{table_name}.#{key} IN (?)", ids)
    end

    # Filtering by boolean
    def filter_by_boolean(results, key, value)
      results.where("#{table_name}.#{key.underscore} IS ?",
                    ActiveModel::Type::Boolean.new.cast(value))
    end

    # Filtering by exact value
    def filter_by_exact_value(results, key, value)
      results.where("#{table_name}.#{key.underscore}=?", value)
    end

    # Default filtering
    def filter_by_value(results, key, value)
      results.where("#{table_name}.#{key.underscore} ILIKE ?", "%#{value}%")
    end

    # Seacrh ordering results
    def search_ordering(results, parameters)
      sort_by = parameters['sort'] || "#{table_name}.id"
      sort_direction = parameters['direction'] || ' ASC'
      results.order("#{sort_by.underscore} #{sort_direction}")
    end
  end
end
