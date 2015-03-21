require 'rails_helper'

describe TopicPolicy do
  let(:user) { User.new }
  let(:topic) { create(:topic) }
  subject { described_class.new(user, topic) }

  describe '#update?' do
    context 'when user is the owner' do
      let(:user) { topic.user }

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

  describe '#edit?' do
    context 'when user is the owner' do
      let(:user) { topic.user }

      it 'returns true' do
        expect(subject.edit?).to be true
      end
    end

    context 'when user is not the owner' do
      it 'returns false' do
        expect(subject.edit?).to be false
      end
    end
  end

  describe '#new?' do
    context 'when user is signed in' do
      let(:user) { User.new }

      it 'returns true' do
        expect(subject.new?).to be true
      end
    end

    context 'when user is not signed in' do
      let(:user) { nil }

      it 'returns false' do
        expect(subject.new?).to be false
      end
    end
  end

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
    context 'when user is the owner' do
      let(:user) { topic.user }

      it 'returns true' do
        expect(subject.destroy?).to be true
      end
    end

    context 'when user is not the owner' do
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
