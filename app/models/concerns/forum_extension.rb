module ForumExtension
  extend ActiveSupport::Concern

  included do
    belongs_to :universe
  end
end
