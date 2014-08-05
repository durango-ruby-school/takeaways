# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :brochure_rack do
    sequence(:name) { |n| "Rack #{n}" }
    number_of_rows 1
    number_of_columns 1
  end
end
