FactoryGirl.define do
  factory :tagging do
    association :taggable, factory: :post

    tag
  end
end
