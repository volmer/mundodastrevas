module Mundodastrevas
  module UserExtension
    extend ActiveSupport::Concern

    included do
      devise :encryptable

      has_many :levels, dependent: :destroy
      has_many :ranks, through: :levels
    end
  end
end
