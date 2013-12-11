require 'spec_helper'

describe UniversePolicy do
  let(:user) { Raddar::User.new }
  subject { described_class.new(user, nil) }

  describe '#index?' do
    context 'when user is an admin' do
      let(:user) { create(:admin) }

      it 'returns true' do
        expect(subject.index?).to be_true
      end
    end

    context 'when user is not an admin' do
      it 'returns false' do
        expect(subject.index?).to be_false
      end
    end
  end

  describe '#update?' do
    context 'when user is an admin' do
      let(:user) { create(:admin) }

      it 'returns true' do
        expect(subject.update?).to be_true
      end
    end

    context 'when user is not an admin' do
      it 'returns false' do
        expect(subject.update?).to be_false
      end
    end
  end

  describe '#new?' do
    context 'when user is an admin' do
      let(:user) { create(:admin) }

      it 'returns true' do
        expect(subject.new?).to be_true
      end
    end

    context 'when user is not an admin' do
      it 'returns false' do
        expect(subject.new?).to be_false
      end
    end
  end

  describe '#create?' do
    context 'when user is an admin' do
      let(:user) { create(:admin) }

      it 'returns true' do
        expect(subject.create?).to be_true
      end
    end

    context 'when user is not an admin' do
      it 'returns false' do
        expect(subject.create?).to be_false
      end
    end
  end

  describe '#destroy?' do
    context 'when user is an admin' do
      let(:user) { create(:admin) }

      it 'returns true' do
        expect(subject.destroy?).to be_true
      end
    end

    context 'when user is not an admin' do
      it 'returns false' do
        expect(subject.destroy?).to be_false
      end
    end
  end

  describe '#show?' do
    it 'returns true' do
      expect(subject.show?).to be_true
    end
  end
end
