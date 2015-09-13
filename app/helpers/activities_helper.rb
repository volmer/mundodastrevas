module ActivitiesHelper
  def activity_content(activity)
    render(
      'activities/' + activity.key.tr('.', '/'), activity: activity
    )
  end
end
