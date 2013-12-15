module Mundodastrevas
  module UserExtension
    extend ActiveSupport::Concern

    included do
      devise :encryptable

      has_many :levels, dependent: :destroy

      def rank_in(universe)
        if universe
          level = levels.find_or_initialize_by(universe: universe)

          if level.new_record?
            level.value = 1
            level.save!
          end

          level.rank
        end
      end
    end
  end
end
