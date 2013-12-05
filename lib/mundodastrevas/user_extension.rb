module Mundodastrevas
  module UserExtension
    extend ActiveSupport::Concern

    included do
      devise :encryptable
    end
  end
end
