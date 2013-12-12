# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user, class: Raddar::User do
    sequence :name do |n|
      "user#{n}"
    end

    email { "#{name}@example.com" }

    password '12345678'

    state 'active'

    before :create do |user|
      user.confirm!
    end

    factory :admin do
      after(:create) do |user, _|
        role = create(:role, name: 'admin')

        user.roles << role
      end
    end
  end
end