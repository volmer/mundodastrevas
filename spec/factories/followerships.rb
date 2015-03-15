# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :followership, class: Raddar::Followership do
    user
    association :followable, factory: :user
  end
end
