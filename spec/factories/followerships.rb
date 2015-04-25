FactoryGirl.define do
  factory :followership do
    user
    association :followable, factory: :user
  end
end
