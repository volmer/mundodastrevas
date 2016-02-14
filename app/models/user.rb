class User < ActiveRecord::Base
  include Searchable
  include DeviseConcern

  NAME_FORMAT = /\A[\w-]+\z/
  NAME_RANGE  = 3..16
  PRIVATE_ATTRIBUTES = %w(email gender location birthday).freeze

  store_accessor :privacy
  store_accessor :email_preferences

  has_many :levels,      dependent: :destroy
  has_many :zines,       dependent: :destroy
  has_many :posts,       dependent: :destroy
  has_many :comments,    dependent: :destroy
  has_many :topics,      dependent: :destroy
  has_many :forum_posts, dependent: :destroy
  has_and_belongs_to_many :roles
  has_many :notifications, dependent: :destroy
  has_many :external_accounts, dependent: :destroy
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
  has_many :watches, dependent: :destroy
  has_many :activities, dependent: :destroy
  has_many :related_activities,
           as: :subject,
           class_name: 'Activity',
           dependent: :destroy

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

  after_create :create_sign_up_activity
  after_update :update_activities

  cattr_accessor(:email_preferences_keys) do
    Notifications.events
  end

  def self.find_by_name!(name)
    find_by!('LOWER(name) = ?', name.downcase)
  end

  def self.find_by_name(name)
    find_by('LOWER(name) = ?', name.downcase)
  end

  def admin?
    roles.exists?(name: 'admin')
  end

  def privacy_keys
    PRIVATE_ATTRIBUTES + external_accounts.map(&:provider)
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

  def as_indexed_json(*)
    as_json(only: [:name])
  end

  private

  def create_sign_up_activity
    Activity.create!(
      user: self, subject: self, key: 'users.sign_up', privacy: 'public'
    )
  end

  def update_activities
    return unless changes.include?(:privacy)

    external_accounts.each do |account|
      account.activity.privacy = privacy[account.provider]
      account.activity.save if account.activity.changed?
    end
  end
end
