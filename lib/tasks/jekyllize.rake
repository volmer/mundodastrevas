require 'fileutils'

namespace :mundodastrevas do
  namespace :jekyllize do
    desc 'Exports all zines as static pages'
    task perform: :environment do
      raise 'Please specify the output dir' unless ARGV[2]
      directories = {}
      [
        :forums,
        :forum_posts,
        :pages,
        :posts,
        :topics,
        :zines
      ].each do |resource|
        directories[resource] = File.join(ARGV[2], "_#{resource}")
        Dir.exist?(directories[resource]) &&
          FileUtils.rm_r(directories[resource])
        Dir.mkdir(directories[resource])
      end

      Zine.all.each do |zine|
        content = <<~ZINEPAGE
          ---
          layout: zine
          id: #{zine.id}
          title: "#{zine.name.gsub('"', '\"')}"
          user: #{zine.user}
          user_image: #{JekyllizeHelpers.img_path zine.user.avatar.small.url}
          user_bio: "#{JekyllizeHelpers.truncate_rich(zine.user.bio).gsub('"', '\"')}"
          slug: #{zine.slug}
          created_at: "#{zine.created_at}"
          updated_at: "#{zine.updated_at}"
          image: #{zine.image}
          ---
          #{zine.description}
          ZINEPAGE
        File.write(File.join(directories[:zines], zine.to_param + '.html'), content)

        zine.posts.each do |post|
          content = <<~POSTPAGE
            ---
            layout: post
            id: #{post.id}
            zine: #{zine.to_param}
            categories: [#{zine.to_param}]
            zine_title: "#{zine.name.gsub('"', '\"')}"
            title: "#{post.name.gsub('"', '\"')}"
            user: #{post.user}
            slug: #{post.slug}
            created_at: "#{post.created_at}"
            updated_at: "#{post.updated_at}"
            image: #{post.image}
            image_small: #{JekyllizeHelpers.img_path post.image.small}
            truncate: "#{JekyllizeHelpers.truncate_rich(post.content).gsub('"', '\"')}"
            ---
            #{post.content}
            POSTPAGE
          File.write(File.join(directories[:posts], "#{post.created_at.to_date}-#{post.to_param}.html"), content)
        end
      end

      Page.all.each do |page|
        content = <<~PAGE
          ---
          layout: page
          slug: #{page.slug}
          title: "#{page.title.gsub('"', '\"')}"
          ---
          #{page.content}
          PAGE

        File.write(File.join(directories[:pages], page.to_param + '.html'), content)
      end

      Forum.all.each do |forum|
        content = <<~FORUMPAGE
          ---
          layout: forum
          name: "#{forum.name}"
          slug: #{forum.slug}
          ---
          #{forum.description}
          FORUMPAGE

        File.write(File.join(directories[:forums], forum.to_param + '.html'), content)

        forum.topics.each do |topic|
          content = <<~TOPICPAGE
            ---
            layout: topic
            name: "#{topic.name.gsub('"', '\"')}"
            slug: #{topic.to_param}
            categories: [#{forum.to_param}]
            forum: #{forum.slug}
            forum_name: "#{forum}"
            posts_count: #{topic.forum_posts.count}
            user: #{topic.user}

            TOPICPAGE

          post = topic.forum_posts.last

          if post
            content += <<~TOPICPAGE
              last_post_created_at: "#{post.created_at}"
              last_post_user_avatar_thumb_url: "#{JekyllizeHelpers.img_path post.user.avatar.thumb.url}"
              last_post_user: #{post.user.name}

              TOPICPAGE

            created_at = post.created_at
          else
            created_at = topic.created_at
          end

          content += "\n---\n"

          File.write(File.join(directories[:topics], "#{created_at.to_date}-#{topic.to_param}.html"), content)

          topic.forum_posts.each do |post|
            content = <<~FORUMPOST
              ---
              created_at: "#{post.created_at}"
              updated_at: "#{post.updated_at}"
              topic: #{topic.to_param}
              user: #{post.user}
              user_avatar: "#{JekyllizeHelpers.img_path post.user.avatar.small.url}"
              ---
              #{post.content}
              FORUMPOST

            File.write(File.join(directories[:forum_posts], "#{post.created_at.to_date}-#{post.id}.html"), content)
          end
        end
      end
    end
  end
end

require 'loofah/helpers'

module JekyllizeHelpers
  module_function

  def truncate_rich(text, length: 300)
    return '' unless text

    doc = Loofah.fragment(text.gsub(/[[:space:]]/, ' '))
    doc.css('br').each { |br| br.replace ' ' }
    safe_text = strip_tags(doc.to_text.gsub(/[[:space:]]/, ' ').strip)
    unescaped = CGI.unescape_html(safe_text)

    truncate(unescaped.squeeze(' '), length: length, separator: ' ')
  end

  def strip_tags(html)
    ActionView::Base.full_sanitizer.sanitize(html, encode_special_chars: false)
  end

  def truncate(text, options = {})
    return unless text
    length  = options.fetch(:length, 30)
    content = text.truncate(length, options)
    ERB::Util.html_escape(content)
  end

  def img_path(path)
    path.to_s.gsub('/assets/', '/images/')
  end
end
