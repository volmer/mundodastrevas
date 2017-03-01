class User < ActiveRecord::Base
  NAME_FORMAT = /\A[\w-]+\z/
  NAME_RANGE  = 3..16

  has_many :zines,       dependent: :destroy
  has_many :posts,       dependent: :destroy
  has_many :comments,    dependent: :destroy
  has_many :topics,      dependent: :destroy
  has_many :forum_posts, dependent: :destroy

  mount_uploader :avatar, ImageUploader

  validates :name,
            presence: true,
            uniqueness: { case_sensitive: false },
            format: { with: NAME_FORMAT },
            length: { in: NAME_RANGE }
  validates :state, presence: true, inclusion: { in: %w(active blocked) }
  validates :bio, length: { maximum: 500 }
  validates :location, length: { maximum: 200 }
  validates :gender, inclusion: { in: %w(male female) }, allow_blank: true

  def to_s
    name
  end
end
