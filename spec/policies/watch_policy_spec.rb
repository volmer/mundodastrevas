require 'rails_helper'

describe WatchPolicy do
  let(:watch) { create(:watch) }
  let(:user) { User.new }

  subject { described_class.new(user, watch) }

  describe '#create?' do
    context 'when user is signed in' do
      it 'returns true' do
        expect(subject.create?).to be true
      end
    end

    context 'when user is not signed in' do
      let(:user) { nil }

      it 'returns false' do
        expect(subject.create?).to be false
      end
    end
  end

  describe '#update?' do
    context 'when user is the owner' do
      let(:user) { watch.user }

      it 'returns true' do
        expect(subject.update?).to be true
      end
    end

    context 'when user is not the owner' do
      it 'returns false' do
        expect(subject.update?).to be false
      end
    end
  end
end