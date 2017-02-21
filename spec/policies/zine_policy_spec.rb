require 'rails_helper'

describe ZinePolicy do
  let(:user) { User.new }
  let(:zine) { create(:zine) }
  subject { described_class.new(user, zine) }

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
