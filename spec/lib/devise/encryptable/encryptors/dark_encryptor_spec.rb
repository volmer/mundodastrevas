require 'rails_helper'

describe Devise::Encryptable::Encryptors::DarkEncryptor do
  it 'is an encryptor' do
    expect(subject).to be_a(Devise::Encryptable::Encryptors::Base)
  end

  describe '.digest' do
    it 'properly encrypts the given password' do
      expected_value = '81c35bdfd7b6bc8878248ae59671c396aa519764'

      expect(described_class.digest('password', 'stretches', 'salt', 'pepper')).to eq(expected_value)
    end
  end
end
