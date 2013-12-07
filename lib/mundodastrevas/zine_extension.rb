module Mundodastrevas
  module ZineExtension
    extend ActiveSupport::Concern

    included do
      belongs_to :universe
    end
  end
end
