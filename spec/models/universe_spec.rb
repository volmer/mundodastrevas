require 'rails_helper'

describe Universe do
  it { is_expected.to have_many(:forums).dependent(:nullify) }
  it { is_expected.to have_many(:zines).dependent(:nullify) }
  it { is_expected.to have_many(:levels).dependent(:restrict_with_exception) }
  it { is_expected.to have_many(:ranks).dependent(:restrict_with_exception) }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to ensure_length_of(:name).is_at_most(100) }

  it { is_expected.to validate_presence_of(:description) }
  it { is_expected.to ensure_length_of(:description).is_at_most(6_000) }

  it { is_expected.to validate_presence_of(:slug) }
  it { is_expected.to validate_uniqueness_of(:slug).case_insensitive }
  it { is_expected.to ensure_length_of(:slug).is_at_least(3).is_at_most(100) }

  it { is_expected.to allow_value('game').for(:slug) }
  it { is_expected.to allow_value('ga-me').for(:slug) }
  it { is_expected.to allow_value('GAME').for(:slug) }
  it { is_expected.to allow_value('game123').for(:slug) }
  it { is_expected.to_not allow_value('ga_me').for(:slug) }
  it { is_expected.to_not allow_value('game!').for(:slug) }

  it 'is a Bootsy container' do
    expect(subject).to be_a_kind_of(Bootsy::Container)
  end

  describe '#to_param' do
    it 'returns its slug' do
      subject.slug = 'werewolf-the-forsaken'

      expect(subject.to_param).to eq('werewolf-the-forsaken')
    end
  end

  describe '#to_s' do
    it 'returns its name' do
      subject.name = 'Werewolf: the Forsaken'

      expect(subject.to_s).to eq('Werewolf: the Forsaken')
    end
  end

  describe '#image' do
    it 'is an uploader field' do
      expect(subject.image).to be_an_instance_of(UniverseImageUploader)
    end
  end

  describe '#highest_rank' do
    it 'returns one of its ranks with the highest value' do
      universe = create(:universe)

      create(:rank, universe: universe, value: 2)
      highest = create(:rank, universe: universe, value: 3)
      create(:rank, universe: universe, value: 1)

      expect(universe.highest_rank).to eq(highest)
    end

    it 'returns nil when it has no ranks' do
      expect(subject.highest_rank).to be_nil
    end
  end
end
