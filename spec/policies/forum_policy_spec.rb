require 'rails_helper'

describe ForumPolicy do
  let(:user) { User.new }
  subject { described_class.new(user, nil) }

  describe '#index?' do
    it 'returns true' do
      expect(subject.index?).to be true
    end
  end

  describe '#show?' do
    it 'returns true' do
      expect(subject.show?).to be true
    end
  end
end
