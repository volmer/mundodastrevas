FactoryGirl.define do
  factory :user do
    sequence :name do |n|
      "user#{n}"
    end

    email { "#{name.downcase}@example.com" }
  end
end
