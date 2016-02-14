require 'rails_helper'

describe Zine do
  subject { build(:zine) }

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

  describe '.with_posts' do
    subject { described_class.with_posts }

    it 'returns zines that have at least one post' do
      zine_with_post = create(:zine)
      create(:post, zine: zine_with_post)
      zine_without_post = create(:zine)

      expect(subject).to include(zine_with_post)
      expect(subject).not_to include(zine_without_post)
    end

    it 'returns one record per zine with posts' do
      zine_with_post = create(:zine)
      create_list(:post, 3, zine: zine_with_post)

      expect(subject.count).to eq(1)
    end
  end
end
