# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :page, class: Raddar::Page do
    sequence :slug do |n|
      "nights-watch-oath-#{n}"
    end

    title "Night's watch oath"

    content "Night gathers, and now my watch begins. It shall not end until
            my death. I shall take no wife, hold no lands, father no children.
            I shall wear no crowns and win no glory. I shall live and die at
            my post. I am the sword in the darkness. I am the watcher on the
            walls. I am the shield that guards the realms of men. I pledge my
            life and honor to the Night's Watch, for this night and all the
            nights to come."
  end
end
