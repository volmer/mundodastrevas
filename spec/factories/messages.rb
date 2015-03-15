# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :message, class: Raddar::Message do
    association :sender, factory: :user
    association :recipient, factory: :user
    content 'Winter is coming.'
  end
end
