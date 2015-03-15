require 'rails_helper'

describe Raddar::Activity, type: :model do
  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:subject) }

  it { is_expected.to validate_presence_of(:user_id) }
  it { is_expected.to validate_presence_of(:subject_id) }
  it { is_expected.to validate_presence_of(:key) }
  it { is_expected.to validate_presence_of(:privacy) }
  it { is_expected.to validate_inclusion_of(:privacy).in_array(['public', 'only_me']) }
end
