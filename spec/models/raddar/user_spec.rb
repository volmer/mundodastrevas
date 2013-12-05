require 'spec_helper'

describe Raddar::User do
  it 'uses devise-encryptable' do
    expect(subject.devise_modules).to include(:encryptable)
  end
end
