# Application base class for active records
class ApplicationRecord < ActiveRecord::Base
  # ==================================================
  # Setup
  # ==================================================
  primary_abstract_class

  # ==================================================
  # Concerns
  # ==================================================
  ##
  # Concerns that gives ability to search into active records
  include SearchConcern

  # ==================================================
  # Instance methods
  # ==================================================
end
