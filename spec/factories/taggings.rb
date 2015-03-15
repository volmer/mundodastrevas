FactoryGirl.define do
  factory :tagging, class: Raddar::Tagging do
    association :taggable, factory: :post

    tag
  end
end
