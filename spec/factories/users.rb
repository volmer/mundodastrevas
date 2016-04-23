FactoryGirl.define do
  factory :user do
    sequence :name do |n|
      "user#{n}"
    end

    email { "#{name.downcase}@example.com" }
    password '12345678'
    state 'active'

    before(:create, &:confirm)

    factory :admin do
      after(:create) do |user, _|
        role = create(:role, name: 'admin')
        user.roles << role
      end
    end
  end
end
