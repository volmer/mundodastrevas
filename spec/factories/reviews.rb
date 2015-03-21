FactoryGirl.define do
  factory :review do
    user

    association :reviewable, factory: :post

    value 'loved'
  end
end
