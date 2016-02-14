FactoryGirl.define do
  factory :notification do
    event 'new_rank'
    association :notifiable, factory: :rank
    user

    factory :new_message_notification do
      event 'new_message'
      association :notifiable, factory: :message
    end
  end
end
