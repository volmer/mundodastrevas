require 'rails_helper'

describe UniversePolicy do
  let(:user) { User.new }
  subject { described_class.new(user, nil) }

  describe '#show?' do
    it 'returns true' do
      expect(subject.show?).to be true
    end
  end
end
