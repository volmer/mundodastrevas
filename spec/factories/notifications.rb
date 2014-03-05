FactoryGirl.define do
  factory :notification, class: Raddar::Notification do
    event 'new_rank'
    user
    association :notifiable, factory: :rank
  end
end
