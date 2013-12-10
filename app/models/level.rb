class Level < ActiveRecord::Base
  belongs_to :user, class_name: 'Raddar::User'
  belongs_to :universe

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
