# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :stocking do
    placement
    quantity 1
    stocked_on "2010-01-01"
  end
end
