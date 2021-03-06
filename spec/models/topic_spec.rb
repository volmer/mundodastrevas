require 'rails_helper'

describe Topic do
  subject(:topic) { build(:topic) }

  describe '#to_param' do
    before do
      subject.id   = 123
      subject.name = 'Wildlings among us'
    end

    it 'is the topic id and the topic name paremeterized' do
      expect(subject.to_param).to eq('123-wildlings-among-us')
    end
  end

  describe '.find_using_slug' do
    let(:topic) { create(:topic) }

    it 'returns the topic that generated the given slug' do
      expect(described_class.find_using_slug(topic.to_param)).to eq(topic)
    end

    it 'raises an error if topic does not exist' do
      expect { described_class.find_using_slug('fake') }
        .to raise_error(ActiveRecord::RecordNotFound)
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
  end

  context 'when it is updated' do
    before { subject.save }

    it 'does not touch its forum' do
      expect(subject.forum).not_to receive(:touch)

      subject.save
    end
  end
end
