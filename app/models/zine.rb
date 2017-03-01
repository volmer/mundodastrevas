class Zine < ActiveRecord::Base
  belongs_to :user
  has_many :posts, dependent: :destroy

  validates :name, presence: true, length: { maximum: 100 }
  validates :description, presence: true, length: { maximum: 66_000 }
  validates :user_id, presence: true
  validates :slug,
            presence: true,
            uniqueness: {
              case_sensitive: false
            },
            format: { with: /\A(([a-z]|[A-Z]|[0-9]|-)+)\z/ },
            length: { maximum: 100, minimum: 3 }

  mount_uploader :image, ImageUploader

  scope :with_posts, -> { joins(:posts).distinct }

  def to_param
    slug
  end

  def to_s
    name
  end
end
