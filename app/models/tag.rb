class Tag < ActiveRecord::Base
  has_many :taggings, dependent: :destroy

  validates :name,
            presence: true,
            uniqueness: {
              case_sensitive: false
            },
            length: {
              maximum: 100
            }

  scope(:trending, lambda do
    select('tags.*, COUNT(taggings.id) AS taggings_count')
      .joins(:taggings)
      .group('tags.id')
      .order('taggings_count DESC')
  end)

  def to_s
    name
  end

  def to_param
    name
  end
end
