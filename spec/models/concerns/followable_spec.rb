require 'rails_helper'

describe Followable do
  subject(:followable) { create(:user) }

  it { is_expected.to be_present }
end
