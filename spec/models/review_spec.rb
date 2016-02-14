require 'rails_helper'

describe Review do
  subject { build(:review) }

  it 'is valid' do
    expect(subject).to be_valid
  end
end
