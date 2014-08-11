# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :takeaway do
    sequence(:name) { |n| "Takeaway #{n}" }
    client
  end
end
