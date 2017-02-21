# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :forum_post do
    user

    topic

    content 'I am the Hand of the King!'
  end
end
