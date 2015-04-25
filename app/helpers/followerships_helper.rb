module FollowershipsHelper
  def follow_link(followable, current_user)
    return if current_user.blank?

    followership = followable.followers.where(user_id: current_user.id).first

    if followership
      build_unfollow_link([followable, followership])
    else
      href = followable_followerships_path(followable)
      build_follow_link(href)
    end
  end

  def following_count(user)
    content =
      content_tag(:strong, user.followerships.count) +
      t('followership.following')

    link_to content, user_following_path(user), class: 'followerships-counter'
  end

  def followers_count(followable)
    href = send(
      "#{ followable.class.model_name.param_key }_followers_path", followable
    )
    count = followable.followers.count
    content =
      content_tag(:strong, count) + t('followership.followers', count: count)

    link_to content, href, class: 'followerships-counter'
  end

  private

  def build_follow_link(href)
    link_to(
      t('followership.follow'),
      href,
      class: 'btn btn-primary',
      method: :post
    )
  end

  def build_unfollow_link(href)
    link_to(
      t('followership.unfollow'),
      href,
      class: 'btn btn-default btn-sm',
      method: :delete
    )
  end

  def followable_followerships_path(followable)
    send(
      "#{followable.class.model_name.param_key}_followerships_path",
      followable
    )
  end
end
