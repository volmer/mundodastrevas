FactoryGirl.define do
  factory :tag, class: Raddar::Tag do
    sequence :name do |n|
      "chronicle#{n}"
    end
  end
end
