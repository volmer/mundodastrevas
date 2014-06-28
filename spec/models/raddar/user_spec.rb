require 'rails_helper'

describe Raddar::User do
  subject(:user) { create(:user) }

  it { should have_many(:levels).dependent(:destroy) }

  it 'uses devise-encryptable' do
    expect(subject.devise_modules).to include(:encryptable)
  end

  describe '#rank_in' do
    subject { user.rank_in(universe) }

    context 'with a valid universe' do
      let(:universe) { create(:universe) }

      context 'when the user does not have a level in the given universe' do
        context 'when the given universe does not have a rank with value 1' do
          it 'returns nil' do
            expect(subject).to be_nil
          end
        end

        context 'when the given universe have a rank with value 1' do
          let!(:rank) { create(:rank, universe: universe, value: 1) }

          it 'sets the user level in the given universe to 1' do
            expect {
              subject
            }.to change {
              user.levels.count
            }.by(1)

            new_level = user.levels.last

            expect(new_level.universe).to eq(universe)
            expect(new_level.value).to eq(1)
          end

          it 'returns the rank' do
            expect(subject).to eq(rank)
          end
        end
      end

      context 'when the user has a level in the given universe' do
        let!(:level) { create(:level, user: user, universe: universe) }

        context 'when the given universe does not have a rank with the level value' do
          it 'returns nil' do
            expect(subject).to be_nil
          end
        end

        context 'when the given universe have a rank with the same value as the user level' do
          let!(:rank) { create(:rank, universe: universe, value: level.value) }

          it 'returns the rank' do
            expect(subject).to eq(rank)
          end
        end
      end
    end

    context 'with a nil universe' do
      let(:universe) { nil }

      it 'returns nil' do
        expect(subject).to be_nil
      end
    end
  end
end
