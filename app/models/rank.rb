class Rank < ActiveRecord::Base
  belongs_to :universe
  has_many :levels, ->(rank){ where(universe: rank.universe) }, foreign_key: 'value', primary_key: 'value'
  has_many :users, through: :levels
  has_many :notifications, as: :notifiable, dependent: :destroy

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

  def to_s
    name
  end
end
