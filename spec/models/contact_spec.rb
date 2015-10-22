require 'rails_helper'

describe Contact do
  context 'with an user' do
    before do
      subject.user = User.new
      subject.valid?
    end

    it 'does not require an email' do
      expect(subject.errors[:email].size).to eq(0)
    end

    it 'does not require a name' do
      expect(subject.errors[:name].size).to eq(0)
    end
  end

  context 'without an user' do
    before { subject.valid? }

    it 'requires an email' do
      expect(subject.errors[:email].size).to eq(1)
    end

    it 'requires a name' do
      expect(subject.errors[:name].size).to eq(1)
    end
  end

  describe '#guest?' do
    context 'with an user' do
      before { subject.user = User.new }

      it 'returns false' do
        expect(subject.guest?).to be false
      end
    end

    context 'without an user' do
      it 'returns true' do
        expect(subject.guest?).to be true
      end
    end
  end

  describe '#name' do
    before { subject.name = 'jon' }

    context 'with an user' do
      before { subject.user = User.new(name: 'daenerys') }

      it 'returns the user name' do
        expect(subject.name).to eq('daenerys')
      end
    end

    context 'without an user' do
      it 'returns the value stored in the name attribute' do
        expect(subject.name).to eq('jon')
      end
    end
  end

  describe '#email' do
    before { subject.email = 'jon@westeros.com' }

    context 'with an user' do
      before { subject.user = User.new(email: 'daenerys@westeros.com') }

      it 'returns the user email' do
        expect(subject.email).to eq('daenerys@westeros.com')
      end
    end

    context 'without an user' do
      it 'returns the value stored in the email attribute' do
        expect(subject.email).to eq('jon@westeros.com')
      end
    end
  end
end
