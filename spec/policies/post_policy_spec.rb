require 'rails_helper'

describe PostPolicy do
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

  describe '#new?' do
    context 'when user is the zine owner' do
      let(:user) { post.zine.user }

      it 'returns true' do
        expect(subject.new?).to be true
      end
    end

    context 'when user is not the zine owner' do
      it 'returns false' do
        expect(subject.new?).to be false
      end
    end
  end

  describe '#create?' do
    context 'when user is the zine owner' do
      let(:user) { post.zine.user }

      it 'returns true' do
        expect(subject.create?).to be true
      end
    end

    context 'when user is not the zine owner' do
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

  describe '#show?' do
    it 'returns true' do
      expect(subject.show?).to be true
    end
  end

  describe '#index?' do
    it 'returns true' do
      expect(subject.index?).to be true
    end
  end
end
