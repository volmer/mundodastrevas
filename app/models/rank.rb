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
end
