FactoryGirl.define do
  factory :activity do
    user
    association :subject, factory: :post
    key 'posts.create'
    privacy 'public'
  end
end
