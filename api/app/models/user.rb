# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  login           :string
#  password_digest :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_login  (login) UNIQUE
#
class User < ApplicationRecord
  # ----------------------------------------
  # SETUP
  # ----------------------------------------
  has_secure_password

  # ----------------------------------------
  # RELATIONSHIPS
  # ----------------------------------------
  has_and_belongs_to_many :weather_locations

  # ----------------------------------------
  # VALIDATES
  # ----------------------------------------
  validates :login, presence:    true,
                    allow_blank: false,
                    uniqueness:  true
  validates :password_digest, presence: true

  # Build token
  def token
    JWT.encode({ id: id, login: login, exp: Time.now.to_i + 3600 },
               ENV.fetch('SECRET_KEY_BASE'),
               'HS256')
  end
end
