require 'spec_helper'

describe Raddar::User do
  it { should have_many(:levels).dependent(:destroy) }
  it { should have_many(:ranks).through(:levels) }

  it 'uses devise-encryptable' do
    expect(subject.devise_modules).to include(:encryptable)
  end
end
