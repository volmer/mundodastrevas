require 'spec_helper'

describe Raddar::User do
  subject(:user) { create(:user) }

  it { should have_many(:levels).dependent(:destroy) }
  it { should have_many(:ranks).through(:levels) }

  it 'uses devise-encryptable' do
    expect(subject.devise_modules).to include(:encryptable)
  end

  describe '#ranks' do
    it 'returns the rank for each of its levels' do
      level = create(:level,  user: user)
      rank = create(:rank, universe: level.universe, value: level.value)

      expect(user.ranks).to include(rank)
    end
  end
end
