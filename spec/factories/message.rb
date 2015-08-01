FactoryGirl.define do
  factory :message do
    sequence(:name) { |n| "Test User #{n}" }
    age { (200*rand()).to_i }
    sequence(:body) { |n| "Test Body #{n}" }
  end
end