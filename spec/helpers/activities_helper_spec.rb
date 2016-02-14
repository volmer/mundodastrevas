require 'rails_helper'

describe ActivitiesHelper, type: :helper do
  let(:activity) { build(:activity) }

  describe '#activity_content' do
    it 'renders the activity partial based on the key' do
      expect(helper).to receive(:render).with(
        'activities/posts/create', activity: activity)

      helper.activity_content(activity)
    end
  end
end
