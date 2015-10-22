require 'rails_helper'

describe Page do
  subject { build(:page) }

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
    it 'returns the page slug' do
      subject.slug = 'nights-watch-oath'

      expect(subject.to_param).to eq('nights-watch-oath')
    end
  end

  describe '#to_s' do
    it 'returns the page title' do
      subject.title = "Night's Watch Oath"

      expect(subject.to_s).to eq("Night's Watch Oath")
    end
  end
end
