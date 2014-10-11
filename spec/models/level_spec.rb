require 'rails_helper'

describe Level do
  subject(:level) { build(:level) }

  it { is_expected.to belong_to(:user).class_name('Raddar::User') }
  it { is_expected.to belong_to(:universe) }

  it { is_expected.to validate_presence_of(:user_id) }
  it { is_expected.to validate_presence_of(:universe_id) }
  it { is_expected.to validate_presence_of(:value) }
  it { is_expected.to validate_numericality_of(:value).is_greater_than(0).only_integer }
  it { is_expected.to validate_uniqueness_of(:user_id).scoped_to(:universe_id) }

  describe '#levels' do
    subject { level.rank }

    it 'returns the rank that belong to the same universe and have the same value' do
      rank_1 = create(:rank, value: level.value)
      rank_2 = create(:rank, universe: level.universe, value: level.value)
      rank_3 = create(:rank, universe: level.universe, value: level.value + 1)

      expect(subject).to eq(rank_2)
    end
  end
end
