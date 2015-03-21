FactoryGirl.define do
  factory :activity do
    user
    association :subject, factory: :post
    key 'followerships.create'
    privacy 'public'
  end
end
