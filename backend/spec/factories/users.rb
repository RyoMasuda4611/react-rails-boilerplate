# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  auth_token      :string           not null
#  email           :string           not null
#  name            :string
#  password_digest :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_auth_token  (auth_token) UNIQUE
#  index_users_on_email       (email) UNIQUE
#
FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "user #{n}" }
    sequence(:email) { |n| "user#{n}@sample.com" }
    password { VALID_PASSWORD }
    password_confirmation { VALID_PASSWORD }
  end
end
