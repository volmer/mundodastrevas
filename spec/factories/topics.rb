# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :topic, class: Raddar::Forums::Topic do
    user

    forum

    name 'The Battle of the Seven Kingdoms'
  end
end
