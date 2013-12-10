require 'spec_helper'

describe Level do
  it { should belong_to(:user).class_name('Raddar::User') }
  it { should belong_to(:universe) }

  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:universe_id) }
  it { should validate_presence_of(:value) }
  it { should validate_numericality_of(:value).is_greater_than(0).only_integer }
  it { should validate_uniqueness_of(:user_id).scoped_to(:universe_id) }
end
