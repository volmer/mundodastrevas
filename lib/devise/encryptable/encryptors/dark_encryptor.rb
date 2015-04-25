require 'digest/sha1'

module Devise
  module Encryptable
    module Encryptors
      class DarkEncryptor < Base
        def self.digest(password, _stretches, salt, _pepper)
          Digest::SHA1.hexdigest "--#{salt}--#{password}--"
        end
      end
    end
  end
end
