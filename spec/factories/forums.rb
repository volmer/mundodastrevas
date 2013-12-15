# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :forum, class: Raddar::Forums::Forum do
    sequence :slug do |n|
      "the-small-council-#{n}"
    end

    name 'The Small Council'

    description 'The small council is a body which advises the King
      of the Seven Kingdoms and institutes policy at his command.
      It is the inner (thus "small") council of the King, effectively
      forming the government cabinet of the Seven Kingdoms. Members
      are appointed to their position by the King; theoretically they
      can be dismissed at will by the King, however in practice this
      might lead to undesirable political fallout.'
  end
end
