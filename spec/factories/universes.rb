# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :universe do
    name 'Vampire: the Requiem'

    description "Vampire: The Requiem is a role-playing game published by White
      Wolf, set in the World of Darkness, and the successor to the Vampire: The
      Masquerade line. It was first released in August 2004, together with a new
      core rule book for the World of Darkness. Although it is an entirely new
      game, rather than a continuation of the previous editions, it uses many elements
      from the old game in its construction, including some of the clans and their
      powers. The game's title is a metaphor for the way vampires within the game
      view their (un)life."

    sequence(:slug) do |n|
      "vampire-the-requiem-#{ n }"
    end
  end
end
