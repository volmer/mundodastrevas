class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :post
  has_many :reviews, as: :reviewable, dependent: :destroy

  validates :content, presence: true, length: { maximum: 6_000 }
  validates :user_id, presence: true
  validates :post_id, presence: true

  def to_s
    I18n.t('descriptive_name.comment', user: user, post: post)
  end
end
