require 'rails_helper'

describe Universe do
  subject { build(:universe) }

  it 'validates slug' do
    subject.slug = 'oath'
    expect(subject).to be_valid

    subject.slug = 'nights-watch-oath'
    expect(subject).to be_valid

    subject.slug = 'NIGHTS-WATCH-OATH'
    expect(subject).to be_valid

    subject.slug = 'OATH123'
    expect(subject).to be_valid

    subject.slug = 'nights_watch_oath'
    expect(subject).not_to be_valid

    subject.slug = 'oath!'
    expect(subject).not_to be_valid
  end

  it 'is a Bootsy container' do
    expect(subject).to be_a_kind_of(Bootsy::Container)
  end

  describe '#to_param' do
    it 'returns its slug' do
      subject.slug = 'werewolf-the-forsaken'

      expect(subject.to_param).to eq('werewolf-the-forsaken')
    end
  end

  describe '#to_s' do
    it 'returns its name' do
      subject.name = 'Werewolf: the Forsaken'

      expect(subject.to_s).to eq('Werewolf: the Forsaken')
    end
  end

  describe '#image' do
    it 'is an uploader field' do
      expect(subject.image).to be_an_instance_of(ImageUploader)
    end
  end
end
