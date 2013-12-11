# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :role, class: Raddar::Role do
    name 'hand_of_the_king'
  end
end
