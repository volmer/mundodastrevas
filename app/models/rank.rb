class Rank < ActiveRecord::Base
  belongs_to :universe

  validates :universe_id, presence: true
  validates :value,
    presence: true,
    numericality: {
      greater_than: 0,
      only_integer: true
    },
    uniqueness: {
      scope: :universe_id
    }
  validates :name,
    presence: true,
    length: {
      maximum: 100
    }
  validates :description,
    presence: true,
    length: {
      maximum: 300
    }
end
