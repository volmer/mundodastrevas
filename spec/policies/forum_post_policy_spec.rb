require 'rails_helper'

describe ForumPostPolicy do
  let(:user) { User.new }
  let(:post) { create(:post) }
  subject { described_class.new(user, post) }

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
end
