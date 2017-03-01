class Page < ActiveRecord::Base
  validates :slug,
            presence: true,
            length: { maximum: 150 },
            uniqueness: true,
            format: { with: /\A(([a-z]|[A-Z]|[0-9]|-)+)\z/ }
  validates :title, presence: true, length: { maximum: 200 }
  validates :content, presence: true, length: { maximum: 60_000 }

  def to_param
    slug
  end

  def to_s
    title
  end
end
