require 'rails_helper'

describe Level do
  subject(:level) { build(:level) }

  describe '#levels' do
    subject { level.rank }

    it 'returns rank that belong to the same universe and has the same value' do
      create(:rank, value: level.value)
      rank2 = create(:rank, universe: level.universe, value: level.value)
      create(:rank, universe: level.universe, value: level.value + 1)

      expect(subject).to eq(rank2)
    end
  end
end
