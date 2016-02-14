class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :reviewable, polymorphic: true

  validates :value, presence: true, inclusion: { in: %w(loved hated) }
  validates :reviewable_id, presence: true
  validates :user_id, presence: true, uniqueness: {
    scope: [:reviewable_id, :reviewable_type]
  }
end
