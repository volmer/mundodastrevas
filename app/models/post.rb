class Post < ActiveRecord::Base
  belongs_to :zine
  belongs_to :user

  has_many :comments, dependent: :destroy
  has_many :reviews, as: :reviewable, dependent: :destroy

  validates :name, presence: true, length: { maximum: 100 }
  validates :content, presence: true, length: { maximum: 66_000 }
  validates :zine_id, presence: true
  validates :slug,
            presence: true,
            uniqueness: {
              case_sensitive: false
            },
            format: { with: /\A(([a-z]|[A-Z]|[0-9]|-)+)\z/ },
            length: { maximum: 100, minimum: 3 }
  validates :user_id, presence: true

  mount_uploader :image, ImageUploader

  after_create :touch_zine

  def to_param
    slug
  end

  def to_s
    name
  end

  protected

  def touch_zine
    zine.try(:touch, :last_post_at)
  end
end
