FactoryGirl.define do
  factory :watch do
    user

    association :watchable, factory: :post
  end
end
