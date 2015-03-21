require 'rails_helper'

describe TagPolicy do
  let(:user) { User.new }
  let(:tag) { create(:tag) }
  subject { described_class.new(user, tag) }

  describe '#show?' do
    it 'returns true' do
      expect(subject.show?).to be true
    end
  end
end
