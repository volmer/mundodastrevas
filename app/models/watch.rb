class Watch < ActiveRecord::Base
  belongs_to :user
  belongs_to :watchable, polymorphic: true

  validates :watchable_id, presence: true
  validates :user_id, presence: true, uniqueness: {
    scope: [:watchable_id, :watchable_type]
  }
end
