require 'rails_helper'

describe Level do
  subject(:level) { build(:level) }

  describe '#levels' do
    subject { level.rank }

    it 'returns the rank that belong to the same universe and have the same value' do
      create(:rank, value: level.value)
      rank_2 = create(:rank, universe: level.universe, value: level.value)
      create(:rank, universe: level.universe, value: level.value + 1)

      expect(subject).to eq(rank_2)
    end
  end
end
