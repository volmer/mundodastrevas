# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :external_account, class: Raddar::ExternalAccount do
    provider 'hubgit'
    sequence(:token) { |n| "mytoken#{n}" }
    sequence(:name) { |n| "arya.stark#{n}" }
    url { "http://hubgit.com/#{name}" }
    user
    sequence(:uid) { |n| n }
  end
end
