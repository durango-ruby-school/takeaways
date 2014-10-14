# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :brochure_rack do
    sequence(:name) { |n| "Rack #{n}" }
  end
end
