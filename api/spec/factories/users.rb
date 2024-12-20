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
FactoryBot.define do
  factory :user do
    sequence(:login) { |n| "login-#{n}" }
    password { 'MyString' }
  end
end
