class Universe < ActiveRecord::Base
  include Bootsy::Container

  mount_uploader :image, ImageUploader

  has_many :forums, dependent: :nullify
  has_many :zines, dependent: :nullify
  has_many :levels, dependent: :restrict_with_exception
  has_many :ranks, dependent: :restrict_with_exception

  validates :name, presence: true, length: { maximum: 100 }
  validates :description, presence: true, length: { maximum: 6_000 }
  validates :slug,
            presence: true,
            uniqueness: {
              case_sensitive: false
            },
            format: { with: /\A(([a-z]|[A-Z]|[0-9]|-)+)\z/ },
            length: { maximum: 100, minimum: 3 }

  def to_param
    slug
  end

  def to_s
    name
  end

  def highest_rank
    ranks.order(value: :desc).first
  end
end
