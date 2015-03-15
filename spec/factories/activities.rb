FactoryGirl.define do
  factory :activity, class: Raddar::Activity do
    user
    association :subject, factory: :post
    key 'followerships.create'
    privacy 'public'
  end
end
