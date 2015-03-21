class Tagging < ActiveRecord::Base
  belongs_to :tag
  belongs_to :taggable, polymorphic: true

  validates :taggable_id, presence: true
  validates :tag_id, presence: true, uniqueness: {
    scope: [:taggable_id, :taggable_type]
  }
end