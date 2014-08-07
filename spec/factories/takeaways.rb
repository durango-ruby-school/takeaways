# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :takeaway do
    name "MyString"
    client
  end
end
