require 'rails_helper'

describe User do
  subject { build :user }

  it 'validates name' do
    subject.name = 'volmaire'
    expect(subject).to be_valid

    subject.name = 'vol_maire'
    expect(subject).to be_valid

    subject.name = 'VOLMAIRE'
    expect(subject).to be_valid

    subject.name = 'vol-maire'
    expect(subject).to be_valid

    subject.name = 'volmaire123'
    expect(subject).to be_valid

    subject.name = 'volmaire!'
    expect(subject).not_to be_valid

    subject.name = 'vol maire'
    expect(subject).not_to be_valid
  end

  describe '#avatar' do
    it 'is an uploader field' do
      expect(subject.avatar).to be_an_instance_of(ImageUploader)
    end
  end

  describe '.find_using_name' do
    it 'retrieves the user with the given name, case insensitive' do
      subject.name = 'Bran'
      subject.save!

      expect(described_class.find_using_name('Bran')).to eq subject
      expect(described_class.find_using_name('bran')).to eq subject
      expect(described_class.find_using_name('BRAN')).to eq subject
    end

    it 'returns nil if nothing is found' do
      expect(
        described_class.find_using_name('unexistent')
      ).to be_nil
    end
  end

  describe '.find_using_name!' do
    it 'retrieves the user with the given name, case insensitive' do
      subject.name = 'Bran'
      subject.save!

      expect(described_class.find_using_name!('Bran')).to eq subject
      expect(described_class.find_using_name!('bran')).to eq subject
      expect(described_class.find_using_name!('BRAN')).to eq subject
    end

    it 'raises an error if nothing is found' do
      expect { described_class.find_using_name!('unexistent') }
        .to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe '#to_s' do
    it 'returns the user name' do
      subject.name = 'volmer'

      expect(subject.to_s).to eq('volmer')
    end
  end

  describe '#to_param' do
    it 'returns the user name' do
      subject.name = 'volmer'

      expect(subject.to_param).to eq('volmer')
    end
  end

  describe '#active?' do
    it 'returns true if it is on the active state' do
      subject.state = 'active'

      expect(subject).to be_active
    end

    it 'returns false if it is not on the active state' do
      subject.state = 'not_active'

      expect(subject).not_to be_active
    end
  end
end
