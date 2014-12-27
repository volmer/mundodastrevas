require 'rails_helper'

describe CommentPolicy do
  let(:user) { Raddar::User.new }
  let(:comment) { create(:comment) }

  subject { described_class.new(user, comment) }

  describe '#create?' do
    context 'when user is signed in' do
      let(:user) { Raddar::User.new }

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
      let(:user) { comment.user }

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