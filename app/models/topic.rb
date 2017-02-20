class Topic < ActiveRecord::Base
  validates :name, presence: true, length: { maximum: 100 }
  validates :views, presence: true
  validates :forum_id, presence: true
  validates :user_id, presence: true

  belongs_to :forum
  belongs_to :user
  has_many :forum_posts, dependent: :destroy

  accepts_nested_attributes_for :forum_posts

  after_create :touch_forum

  scope :recent, -> { order(updated_at: :desc) }

  def to_param
    "#{id}-#{name.parameterize}"
  end

  def to_s
    name
  end

  def self.find_using_slug(slug)
    id = slug.split('-').first
    find_by!(id: id)
  end

  protected

  def touch_forum
    forum.touch
  end
end
