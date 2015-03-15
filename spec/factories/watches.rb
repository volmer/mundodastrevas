FactoryGirl.define do
  factory :watch, class: Raddar::Watch do
    user

    association :watchable, factory: :post
  end
end
