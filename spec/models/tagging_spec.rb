require 'rails_helper'

describe Raddar::Tagging do
  it { should belong_to(:tag) }
  it { should belong_to(:taggable) }

  it { should validate_presence_of(:tag_id) }
  it { should validate_presence_of(:taggable_id) }
  it { should validate_uniqueness_of(:tag_id).scoped_to(:taggable_id, :taggable_type) }
end
