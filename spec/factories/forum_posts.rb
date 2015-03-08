# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :forum_post do
    transient do
      universe nil
    end

    user

    topic

    content 'I am the Hand of the King!'

    after(:create) do |post, evaluator|
      forum = post.topic.forum
      forum.universe = evaluator.universe
      forum.save!
    end
  end
end
