require 'rails_helper'

describe Raddar::Followable do
  subject(:followable) { create(:user) }

  it { is_expected.to have_many(:activities).dependent(:destroy) }
  it { is_expected.to have_many(:followers).class_name('Raddar::Followership').dependent(:destroy) }
end
