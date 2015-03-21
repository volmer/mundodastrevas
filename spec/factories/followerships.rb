# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :followership do
    user
    association :followable, factory: :user
  end
end
