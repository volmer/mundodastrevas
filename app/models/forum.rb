class Forum < ActiveRecord::Base
  include PgSearch

  multisearchable against: [:name, :description]

  validates :name, presence: true, length: { maximum: 100 }
  validates :description, presence: true, length: { maximum: 500 }
  validates :slug,
            presence: true,
            length: { maximum: 100 },
            uniqueness: true,
            format: { with: /\A(([a-z]|[A-Z]|[0-9]|-)+)\z/ }

  has_many :topics, dependent: :destroy
  has_many :followers,
           class_name: 'Followership',
           as: :followable,
           dependent: :destroy
  belongs_to :universe

  def to_param
    slug
  end

  def to_s
    name
  end
end
