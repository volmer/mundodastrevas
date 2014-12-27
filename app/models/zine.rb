class Zine < ActiveRecord::Base
  include PgSearch
  include Bootsy::Container

  multisearchable against: [:name, :description]

  belongs_to :user, class_name: 'Raddar::User'
  belongs_to :universe
  has_many :followers,
           class_name: 'Raddar::Followership',
           as: :followable,
           dependent: :destroy
  has_many :posts, dependent: :destroy
  has_one :activity, class_name: 'Raddar::Activity', as: :subject, dependent: :destroy

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

  scope :with_posts, -> { joins(:posts).uniq }

  after_create :create_activity

  def to_param
    slug
  end

  def to_s
    name
  end

  private

  def create_activity
    Raddar::Activity.create!(
      user: user,
      subject: self,
      key: 'zines.create',
      privacy: 'public'
    )
  end
end