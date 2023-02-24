FactoryBot.define do
  factory :volunteer do
    sequence(:email) { |n| "test-#{n}@test.com" }
  end
end
