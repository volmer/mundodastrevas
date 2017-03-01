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

  describe '#to_s' do
    it 'returns the user name' do
      subject.name = 'volmer'

      expect(subject.to_s).to eq('volmer')
    end
  end
end
