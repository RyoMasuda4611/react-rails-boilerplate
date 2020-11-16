FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "user #{n}" }
    sequence(:email) { |n| "user#{n}@sample.com" }
    password { VALID_PASSWORD }
    password_confirmation { VALID_PASSWORD }
  end
end
