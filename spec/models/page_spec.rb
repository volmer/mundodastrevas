require 'rails_helper'

describe Raddar::Page do
  it { is_expected.to validate_presence_of(:slug) }
  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:content) }
  it { is_expected.to validate_length_of(:slug).is_at_most(150) }
  it { is_expected.to validate_length_of(:title).is_at_most(200) }
  it { is_expected.to validate_length_of(:content).is_at_most(60_000) }
  it { is_expected.to validate_uniqueness_of(:slug) }

  it { is_expected.to allow_value('oath').for(:slug) }
  it { is_expected.to allow_value('nights-watch-oath').for(:slug) }
  it { is_expected.to allow_value('NIGHTS-WATCH-OATH').for(:slug) }
  it { is_expected.to allow_value('OATH123').for(:slug) }
  it { is_expected.to_not allow_value('nights_watch_oath').for(:slug) }
  it { is_expected.to_not allow_value('oath!').for(:slug) }

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
