require 'rails_helper'

describe FollowershipPolicy do
  subject { described_class.new(user, record) }
  let(:record) { Followership.new }

  describe '#create?' do
    context 'when user is signed in' do
      let(:user) { User.new }

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

  describe '#destroy?' do
    context 'when user is signed in' do
      let(:user) { User.new }

      it 'returns true' do
        expect(subject.destroy?).to be true
      end
    end

    context 'when user is not signed in' do
      let(:user) { nil }

      it 'returns false' do
        expect(subject.destroy?).to be false
      end
    end
  end

  describe '#followers?' do
    context 'when user is signed in' do
      let(:user) { User.new }

      it 'returns true' do
        expect(subject.followers?).to be true
      end
    end

    context 'when user is not signed in' do
      let(:user) { nil }

      it 'returns false' do
        expect(subject.followers?).to be false
      end
    end
  end

  describe '#following?' do
    context 'when user is signed in' do
      let(:user) { User.new }

      it 'returns true' do
        expect(subject.following?).to be true
      end
    end

    context 'when user is not signed in' do
      let(:user) { nil }

      it 'returns false' do
        expect(subject.following?).to be false
      end
    end
  end
end
