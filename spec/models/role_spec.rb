require 'rails_helper'

describe Role do
  it { is_expected.to have_and_belong_to_many(:users) }

  it { is_expected.to validate_uniqueness_of(:name).case_insensitive }
  it { is_expected.to validate_presence_of(:name) }
end
