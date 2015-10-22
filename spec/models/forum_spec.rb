require 'rails_helper'

describe Forum do
  subject { build(:forum) }

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
    it 'returns the forum slug' do
      subject.slug = 'the-small-council'

      expect(subject.to_param).to eq('the-small-council')
    end
  end

  describe '#to_s' do
    it 'returns the forum name' do
      subject.name = 'The Small Council'

      expect(subject.to_s).to eq('The Small Council')
    end
  end
end
