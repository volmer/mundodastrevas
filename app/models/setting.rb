class Setting < ActiveRecord::Base
  validates :key, presence: true, uniqueness: true

  def self.[]=(key, value)
    setting = find_or_initialize_by(key: key)
    setting.value = value
    setting.save!
  end

  def self.[](key)
    find_by(key: key).try(:value)
  end
end
