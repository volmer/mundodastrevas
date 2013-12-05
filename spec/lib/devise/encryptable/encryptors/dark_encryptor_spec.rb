require 'spec_helper'

describe Devise::Encryptable::Encryptors::DarkEncryptor do
  it 'is an encryptor' do
    expect(subject).to be_a(Devise::Encryptable::Encryptors::Base)
  end

  describe '.digest' do
    it 'properly encrypts the given password' do
      expected_value = 'fe56bbcd912aa97a8ffe5ca2b887794a61bddfab'

      expect(described_class.digest('password', 'stretches', 'salt', 'pepper')).to eq(expected_value)
    end
  end
end
