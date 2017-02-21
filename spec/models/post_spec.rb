require 'rails_helper'

describe Post do
  subject { build(:post) }

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

  describe '#to_param' do
    it 'returns its slug' do
      subject.slug = 'a-song-of-ice-and-fire'

      expect(subject.to_param).to eq('a-song-of-ice-and-fire')
    end
  end

  describe '#to_s' do
    it 'returns its name' do
      subject.name = 'A Song of Ice and Fire'

      expect(subject.to_s).to eq('A Song of Ice and Fire')
    end
  end

  describe '#image' do
    it 'is an uploader field' do
      expect(subject.image).to be_an_instance_of(ImageUploader)
    end
  end

  context 'when it is created' do
    subject! { build(:post) }

    it 'touches its zine' do
      expect(subject.zine).to receive(:touch).with(:last_post_at)

      subject.save
    end
  end

  context 'when it is updated' do
    before { subject.save }

    it 'does not touch its zine' do
      expect(subject.zine).not_to receive(:touch)

      subject.save
    end
  end
end
