require 'spec_helper'

describe Rank do
  it { should belong_to(:universe) }

  it { should validate_presence_of(:universe_id) }
  it { should validate_presence_of(:value) }
  it { should validate_numericality_of(:value).is_greater_than(0).only_integer }
  it { should validate_uniqueness_of(:value).scoped_to(:universe_id) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:description) }
  it { should ensure_length_of(:name).is_at_most(100) }
  it { should ensure_length_of(:description).is_at_most(300) }
end
