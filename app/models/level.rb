class Level < ActiveRecord::Base
  belongs_to :user
  belongs_to :universe
  belongs_to :rank, ->(level) { where(universe: level.universe) }, primary_key: 'value', foreign_key: 'value'

  validates :user_id,
    presence: true,
    uniqueness: {
      scope: :universe_id
    }
  validates :universe_id, presence: true
  validates :value,
    presence: true,
    numericality: {
      greater_than: 0,
      only_integer: true
    }
end
