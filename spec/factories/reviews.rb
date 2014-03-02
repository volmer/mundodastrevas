FactoryGirl.define do
  factory :review, class: Raddar::Ratings::Review do
    user

    association :reviewable, factory: :post

    value 'loved'
  end
end
