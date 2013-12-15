# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :post, class: Raddar::Forums::Post do
    user

    topic

    content 'I am the Hand of the King!'
  end
end
