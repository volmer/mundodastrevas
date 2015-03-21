atom_feed language: I18n.locale do |feed|
  feed.title Rails.application.config.app_name
  feed.updated @posts.first.try(:updated_at)

  @posts.each do |post|
    feed.entry post, { url: zine_post_url(post.zine, post) } do |entry|
      entry.title post.name
      entry.content render('feed_body.html', post: post), type: 'html'

      entry.author do |author|
        author.name post.user.name
      end
    end
  end
end
