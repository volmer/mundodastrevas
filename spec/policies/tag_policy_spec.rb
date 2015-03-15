require 'rails_helper'

describe Raddar::TagPolicy do
  let(:user) { Raddar::User.new }
  let(:tag) { create(:tag) }
  subject { described_class.new(user, tag) }

  describe '#show?' do
    it 'returns true' do
      expect(subject.show?).to be true
    end
  end
end
