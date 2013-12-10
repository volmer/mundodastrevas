module Mundodastrevas
  module UserExtension
    extend ActiveSupport::Concern

    included do
      devise :encryptable

      has_many :levels, dependent: :destroy
    end
  end
end
