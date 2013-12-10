class Universe < ActiveRecord::Base
  include Bootsy::Container

  mount_uploader :image, ImageUploader

  has_many :forums, class_name: 'Raddar::Forums::Forum', dependent: :nullify
  has_many :zines, class_name: 'Raddar::Zines::Zine', dependent: :nullify
  has_many :levels, dependent: :destroy

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
    self.slug
  end

  def to_s
    self.name
  end
end
