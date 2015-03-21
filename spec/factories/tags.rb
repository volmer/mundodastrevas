FactoryGirl.define do
  factory :tag do
    sequence :name do |n|
      "chronicle#{n}"
    end
  end
end
