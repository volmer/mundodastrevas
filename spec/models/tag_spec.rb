require 'rails_helper'

describe Tag do
  describe '#to_param' do
    it 'returns its name' do
      subject.name = 'A Song of Ice and Fire'

      expect(subject.to_param).to eq('A Song of Ice and Fire')
    end
  end

  describe '#to_s' do
    it 'returns its name' do
      subject.name = 'A Song of Ice and Fire'

      expect(subject.to_s).to eq('A Song of Ice and Fire')
    end
  end

  describe '.trending' do
    subject { described_class.trending }

    let(:less_used) { create(:tag) }
    let(:second_position) { create(:tag) }
    let(:most_used) { create(:tag) }

    before do
      create_list(:tagging, 3, tag: second_position)
      create_list(:tagging, 5, tag: most_used)
      create_list(:tagging, 2, tag: less_used)
    end

    it 'returns tags ordered by the most used' do
      expect(subject.first).to eq(most_used)
      expect(subject.last).to eq(less_used)
    end

    it 'returns all tags' do
      expect(subject.length).to eq(3)
    end

    it 'includes the number of taggings in each tag as :taggings_count' do
      expect(subject.first.taggings_count).to eq(5)
      expect(subject.last.taggings_count).to eq(2)
    end
  end
end
