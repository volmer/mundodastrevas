require 'rails_helper'

describe PostPolicy do
  let(:user) { User.new }
  let(:post) { create(:post) }
  subject { described_class.new(user, post) }

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
