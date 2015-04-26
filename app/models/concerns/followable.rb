module Followable
  extend ActiveSupport::Concern

  included do
    has_many :activities,
             class_name: 'Followership',
             as: :followable,
             dependent: :destroy

    has_many :followers,
             class_name: 'Followership',
             as: :followable,
             dependent: :destroy
  end
end
