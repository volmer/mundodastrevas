module ActivitiesHelper
  def activity_content(activity)
    render(
      'activities/' + activity.key.gsub('.', '/'), activity: activity
    )
  end
end
