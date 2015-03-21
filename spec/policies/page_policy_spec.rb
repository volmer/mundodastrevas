require 'rails_helper'

describe PagePolicy do
  let(:user) { User.new }
  subject { described_class.new(user, nil) }

  describe '#index?' do
    context 'when user is an admin' do
      let(:user) { create(:admin) }

      it 'returns true' do
        expect(subject.index?).to be true
      end
    end

    context 'when user is not an admin' do
      it 'returns false' do
        expect(subject.index?).to be false
      end
    end
  end

  describe '#update?' do
    context 'when user is an admin' do
      let(:user) { create(:admin) }

      it 'returns true' do
        expect(subject.update?).to be true
      end
    end

    context 'when user is not an admin' do
      it 'returns false' do
        expect(subject.update?).to be false
      end
    end
  end

  describe '#new?' do
    context 'when user is an admin' do
      let(:user) { create(:admin) }

      it 'returns true' do
        expect(subject.new?).to be true
      end
    end

    context 'when user is not an admin' do
      it 'returns false' do
        expect(subject.new?).to be false
      end
    end
  end

  describe '#create?' do
    context 'when user is an admin' do
      let(:user) { create(:admin) }

      it 'returns true' do
        expect(subject.create?).to be true
      end
    end

    context 'when user is not an admin' do
      it 'returns false' do
        expect(subject.create?).to be false
      end
    end
  end

  describe '#destroy?' do
    context 'when user is an admin' do
      let(:user) { create(:admin) }

      it 'returns true' do
        expect(subject.destroy?).to be true
      end
    end

    context 'when user is not an admin' do
      it 'returns false' do
        expect(subject.destroy?).to be false
      end
    end
  end

  describe '#show?' do
    it 'returns true' do
      expect(subject.show?).to be true
    end
  end
end
