FactoryGirl.define do
  factory :zine_post, class: Raddar::Zines::Post do
    name 'Chapter XIX - Brienne'

    content "Brienne gazes out at the Quiet Isle, set in the middle of
      the Trident where it widens before emptying into the Bay of Crabs. Meribald
      tells her that the brothers will ferry them over to Saltpans on the morning
      tide and that they should stay at the monastery for the night. Podrick asks
      why it is called the Quiet Isle, and Meribald explains that the brothers have
      taken a vow of silence, and that only the Elder Brother and his proctors are
      permitted to speak, though the proctors may only speak on one day out of every
      seven."

    zine

    sequence :slug do |n|
      "#{ n }-brienne"
    end

    user
  end
end
