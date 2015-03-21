require 'rails_helper'

describe ForumPostPolicy do
  let(:user) { User.new }
  let(:post) { create(:post) }
  subject { described_class.new(user, post) }

  describe '#update?' do
    context 'when user is the owner' do
      let(:user) { post.user }

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
      let(:user) { post.user }

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
      let(:user) { post.user }

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
end
