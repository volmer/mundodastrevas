require 'rails_helper'

describe Topic do
  subject(:topic) { build(:topic) }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:views) }
  it { is_expected.to validate_presence_of(:forum_id) }
  it { is_expected.to validate_presence_of(:user_id) }
  it { is_expected.to validate_length_of(:name).is_at_most(100) }

  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:forum) }
  it { is_expected.to have_many(:forum_posts).dependent(:destroy) }

  it 'is watchable' do
    expect(subject).to be_a_kind_of(Watchable)
  end

  describe '#to_param' do
    before do
      subject.id   = 123
      subject.name = 'Wildlings among us'
    end

    it 'starts with the topic id followed by an hyphen and the topic name paremeterized' do
      expect(subject.to_param).to eq('123-wildlings-among-us')
    end
  end

  describe '.find_by_slug!' do
    let(:topic) { create(:topic) }

    it 'returns the topic that generated the given slug' do
      expect(described_class.find_by_slug!(topic.to_param)).to eq(topic)
    end

    it 'raises an error if topic does not exist' do
      expect {
        described_class.find_by_slug!('fake')
      }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe '#to_s' do
    it 'returns its name' do
      subject.name = 'The Small Council'

      expect(subject.to_s).to eq('The Small Council')
    end
  end

  context 'when it is created' do
    it 'touches its forum' do
      expect(subject.forum).to receive(:touch)

      subject.save
    end

    it 'sets the post user as a watcher' do
      subject.save

      expect(subject).to be_watched_by(subject.user)
    end
  end

  context 'when it is updated' do
    before { subject.save }

    it 'does not touch its forum' do
      expect(subject.forum).not_to receive(:touch)

      subject.save
    end
  end
end
