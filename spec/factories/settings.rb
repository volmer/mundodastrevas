# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :setting do
    key 'my_setting'
    value 'My value'
  end
end
