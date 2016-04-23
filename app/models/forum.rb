class Forum < ActiveRecord::Base
  validates :name, presence: true, length: { maximum: 100 }
  validates :description, presence: true, length: { maximum: 500 }
  validates :slug,
            presence: true,
            length: { maximum: 100 },
            uniqueness: true,
            format: { with: /\A(([a-z]|[A-Z]|[0-9]|-)+)\z/ }

  has_many :topics, dependent: :destroy
  belongs_to :universe

  def to_param
    slug
  end

  def to_s
    name
  end
end
