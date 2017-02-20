require 'rails_helper'

describe Rank do
  subject(:rank) { build(:rank) }

  describe '#to_s' do
    it 'returns its name' do
      subject.name = 'Mortal'

      expect(subject.to_s).to eq('Mortal')
    end
  end

  describe '#levels' do
    subject { rank.levels }

    it 'returns all levels with the same universe and value' do
      level1 = create(:level, universe: rank.universe, value: rank.value)
      level2 = create(:level, universe: rank.universe, value: rank.value + 1)
      level3 = create(:level, value: rank.value)

      expect(subject).to include(level1)
      expect(subject).not_to include(level2)
      expect(subject).not_to include(level3)
    end
  end

  describe '#users' do
    subject { rank.users }

    it 'returns all users that have a level with the same value and universe' do
      level = create(:level, universe: rank.universe, value: rank.value)
      level_with_different_value =
        create(:level, universe: rank.universe, value:
          create(:rank, universe: rank.universe, value: (rank.value + 1)).value)
      level_of_another_universe = create(:level, value: rank.value)

      expect(subject).to include(level.user)
      expect(subject).not_to include(level_with_different_value)
      expect(subject).not_to include(level_of_another_universe)
    end
  end
end
