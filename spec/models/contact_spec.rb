require 'rails_helper'

describe Contact do
  describe 'validations' do
    before { subject.valid? }

    it 'requires an email' do
      expect(subject.errors[:email].size).to eq(1)
    end

    it 'requires a name' do
      expect(subject.errors[:name].size).to eq(1)
    end
  end
end
