require 'rails_helper'

describe ExternalAccount do
  subject { build(:external_account) }

  describe '#to_s' do
    it 'is #name' do
      subject.name = 'volmer'

      expect(subject.to_s).to eq('volmer')
    end

    it 'is #email if #name is not present' do
      subject.email = 'my@email.com'

      subject.name = nil
      expect(subject.to_s).to eq('my@email.com')

      subject.name = ' '
      expect(subject.to_s).to eq('my@email.com')
    end
  end
end
