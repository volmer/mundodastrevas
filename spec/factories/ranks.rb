# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :rank do
    name "MyString"
    description "MyText"
    universe nil
    value 1
  end
end
