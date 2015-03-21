require 'rails_helper'

describe Watch do
  it { should belong_to(:user) }
  it { should belong_to(:watchable) }

  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:watchable_id) }
  it { should validate_uniqueness_of(:user_id).scoped_to(:watchable_id, :watchable_type) }
end
