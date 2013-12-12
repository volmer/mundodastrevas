require 'spec_helper'

describe Rank do
  subject(:rank) { build(:rank) }

  it { should belong_to(:universe) }
  it { should have_many(:users).through(:levels) }

  it { should validate_presence_of(:universe_id) }
  it { should validate_presence_of(:value) }
  it { should validate_numericality_of(:value).is_greater_than(0).only_integer }
  it { should validate_uniqueness_of(:value).scoped_to(:universe_id) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:description) }
  it { should ensure_length_of(:name).is_at_most(100) }
  it { should ensure_length_of(:description).is_at_most(300) }

  describe '#to_s' do
    it 'returns its name' do
      subject.name = 'Mortal'

      expect(subject.to_s).to eq('Mortal')
    end
  end

  describe '#levels' do
    subject { rank.levels }

    it 'returns all levels that belong to the same universe and have the same value' do
      level_1 = create(:level, universe: rank.universe, value: rank.value)
      level_2 = create(:level, universe: rank.universe, value: rank.value + 1)
      level_3 = create(:level, value: rank.value)

      expect(subject).to include(level_1)
      expect(subject).not_to include(level_2)
      expect(subject).not_to include(level_3)
    end
  end
end