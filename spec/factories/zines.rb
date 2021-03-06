FactoryGirl.define do
  factory :zine do
    sequence :slug do |n|
      "a-song-of-ice-and-fire-#{n}"
    end

    name 'A Song of Ice and Fire'

    description "A Song of Ice and Fire is a series of epic fantasy novels
      written by American novelist and screenwriter George R. R. Martin. Martin
      began the first volume of the series, A Game of Thrones, in 1991. He
      published it in 1996. Martin gradually extended his originally intended
      trilogy to seven volumes, the fifth of which, A Dance with Dragons, took
      him five years to write before its publication in 2011. Martin's work on
      his sixth, The Winds of Winter, is still underway."

    user
  end
end
