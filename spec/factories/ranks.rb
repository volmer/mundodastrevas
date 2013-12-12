# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :rank do
    name 'Mortal'

    description 'A prey for the vampires.'

    universe

    value 1
  end
end
