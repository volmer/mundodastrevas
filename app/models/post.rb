class Post < ActiveRecord::Base
  include Searchable
  include Watchable
  include Taggable

  belongs_to :zine
  belongs_to :user

  has_many :comments, dependent: :destroy
  has_many :reviews, as: :reviewable, dependent: :destroy
  has_one :activity, as: :subject, dependent: :destroy

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

  after_create :touch_zine, :watch_it, :create_activity

  def to_param
    slug
  end

  def to_s
    name
  end

  def as_indexed_json(*)
    as_json(only: [:name, :content])
  end

  protected

  def touch_zine
    zine.try(:touch, :last_post_at)
  end

  def watch_it
    set_watcher!(user, active: true) if user.present?
  end

  private

  def create_activity
    Activity.create!(
      user: user,
      subject: self,
      key: 'posts.create',
      privacy: 'public'
    )
  end
end
