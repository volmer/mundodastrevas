require 'loofah/helpers'

module ApplicationHelper
  def simple_text(text)
    result = sanitize(simple_format(text), tags: %w(p br), attributes: [])
    result = autolink_mentions(result)
    auto_link(result, html: { target: '_blank' })
  end

  def truncate_rich(text, length: 300, &block)
    return '' unless text

    doc = Loofah.fragment(text.gsub(/[[:space:]]/, ' '))
    doc.css('br').each { |br| br.replace ' ' }
    safe_text = strip_tags(doc.to_text.gsub(/[[:space:]]/, ' ').strip)

    truncate(safe_text.squeeze(' '), length: length, separator: ' ', &block)
  end

  def autolink_mentions(text)
    each_mention_on(text) do |name, occurence|
      if (user = User.find_by_name(name))
        mention = "@#{name}"
        occurence.sub(mention, link_to(mention, user_path(user)))
      else
        occurence
      end
    end || ''
  end

  def mentioned_users(text)
    users = []

    each_mention_on(text) do |name, _|
      unless users.map(&:name).include?(name)
        user = User.find_by_name(name)
        users << user if user
      end
    end

    users
  end

  private

  def each_mention_on(text)
    return unless text

    mentions_regexp = /(\A|\W)@([\w-]{3,})/

    text.gsub(mentions_regexp) do |occurence|
      name = occurence.match(mentions_regexp)[2]
      yield(name, occurence)
    end
  end
end
