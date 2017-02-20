class User < ActiveRecord::Base
  include DeviseConcern

  NAME_FORMAT = /\A[\w-]+\z/
  NAME_RANGE  = 3..16
  PRIVATE_ATTRIBUTES = %w(email gender location birthday).freeze

  store_accessor :privacy

  has_many :levels,      dependent: :destroy
  has_many :zines,       dependent: :destroy
  has_many :posts,       dependent: :destroy
  has_many :comments,    dependent: :destroy
  has_many :topics,      dependent: :destroy
  has_many :forum_posts, dependent: :destroy
  has_many :sent_messages,
           class_name: 'Message',
           inverse_of: :sender,
           foreign_key: 'sender_id',
           dependent: :destroy
  has_many :incoming_messages,
           class_name: 'Message',
           inverse_of: :recipient,
           foreign_key: 'recipient_id',
           dependent: :destroy
  has_many :reviews, dependent: :destroy

  mount_uploader :avatar, ImageUploader

  validates :name,
            presence: true,
            uniqueness: { case_sensitive: false },
            format: { with: NAME_FORMAT },
            length: { in: NAME_RANGE }
  validates :state, presence: true, inclusion: { in: %w(active blocked) }
  validates :bio, length: { maximum: 500 }
  validates :location, length: { maximum: 200 }
  validates :gender, inclusion: { in: %w(male female) }, allow_blank: true

  def self.find_using_name!(name)
    find_by!('LOWER(name) = ?', name.downcase)
  end

  def self.find_using_name(name)
    find_by('LOWER(name) = ?', name.downcase)
  end

  def privacy_keys
    PRIVATE_ATTRIBUTES
  end

  def to_s
    name
  end

  def to_param
    name
  end

  def active?
    state == 'active'
  end

  def rank_in(universe)
    return if universe.blank?

    level = levels.find_or_initialize_by(universe: universe)

    if level.new_record?
      level.value = 1
      level.save!
    end

    level.rank
  end
end
