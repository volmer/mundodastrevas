require 'rails_helper'

describe Raddar do
  subject { Raddar }

  describe '.setup' do
    it 'yields self' do
      subject.setup do |config|
        expect(config).to eq(subject)
      end
    end
  end

  describe '.app_name' do
    it 'defaults to Mundo das Trevas' do
      expect(subject.app_name).to eq('Mundo das Trevas')
    end
  end

  describe '.default_from' do
    it 'defaults to admin@mundodastrevas.com' do
      expect(subject.default_from).to eq('admin@mundodastrevas.com')
    end
  end

  describe '.contacts_destination' do
    it 'defaults to contato@mundodastrevas.com' do
      expect(subject.contacts_destination).to eq('contato@mundodastrevas.com')
    end
  end

  describe '.main_links' do
    it 'defaults to a non-empty array' do
      expect(subject.main_links).not_to be_empty
    end
  end

  describe '.admin_links' do
    it 'defaults to a non-empty array' do
      expect(subject.admin_links).not_to be_empty
    end
  end

  describe '.user_menu' do
    it 'defaults to a non-empty array' do
      expect(subject.user_menu).not_to be_empty
    end
  end
end
