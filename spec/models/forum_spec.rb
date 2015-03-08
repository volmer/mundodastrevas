require 'rails_helper'

describe Forum do
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:description) }
  it { is_expected.to ensure_length_of(:name).is_at_most(100) }
  it { is_expected.to ensure_length_of(:description).is_at_most(500) }
  it { is_expected.to validate_presence_of(:slug) }
  it { is_expected.to ensure_length_of(:slug).is_at_most(100) }
  it { is_expected.to validate_uniqueness_of(:slug) }
  it { is_expected.to allow_value('oath').for(:slug) }
  it { is_expected.to allow_value('nights-watch-oath').for(:slug) }
  it { is_expected.to allow_value('NIGHTS-WATCH-OATH').for(:slug) }
  it { is_expected.to allow_value('OATH123').for(:slug) }
  it { is_expected.not_to allow_value('nights_watch_oath').for(:slug) }
  it { is_expected.not_to allow_value('oath!').for(:slug) }

  it { is_expected.to have_many(:topics).dependent(:destroy) }
  it { is_expected.to have_many(:followers).class_name('Raddar::Followership').dependent(:destroy) }
  it { is_expected.to belong_to(:universe) }

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
