require 'rails_helper'

describe Setting, type: :model do
  it { is_expected.to validate_presence_of(:key) }
  it { is_expected.to validate_uniqueness_of(:key) }

  describe '.[]=' do
    it 'creates a new setting for the given key and value if key does not exist' do
      Setting[:admin_name] = 'Volmer'

      expect(Setting.find_by(key: :admin_name).value).to eq('Volmer')
    end

    it 'update an already existing key if key exists' do
      setting = Setting.create!(key: :admin_name, value: 'Volmer')
      Setting[:admin_name] = 'Ramona'
      setting.reload

      expect(setting.value).to eq('Ramona')
    end
  end

  describe '.[]' do
    it 'returns the value if the given key exists' do
      Setting[:admin_name] = 'Ramona'

      expect(Setting[:admin_name]).to eq('Ramona')
    end

    it 'returns nil if the given key does not exist' do
      expect(Setting[:admin_name]).to be_nil
    end
  end
end
