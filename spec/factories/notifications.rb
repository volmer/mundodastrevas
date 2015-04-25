FactoryGirl.define do
  factory :notification do
    event 'new_rank'
    association :notifiable, factory: :rank
    user

    factory :new_follower_notification do
      event 'new_follower'
      association :notifiable, factory: :followership
    end

    factory :new_message_notification do
      event 'new_message'
      association :notifiable, factory: :message
    end
  end
end
