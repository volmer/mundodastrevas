class Activity < ActiveRecord::Base
  belongs_to :user
  belongs_to :subject, polymorphic: true

  validates :user_id, presence: true
  validates :subject_id, presence: true
  validates :key, presence: true
  validates :privacy, presence: true, inclusion: { in: %w(public only_me) }
end
