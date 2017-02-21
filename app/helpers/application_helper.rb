require 'loofah/helpers'

module ApplicationHelper
  def simple_text(text)
    result = sanitize(simple_format(text), tags: %w(p br), attributes: [])
    auto_link(result, html: { target: '_blank' })
  end

  def truncate_rich(text, length: 300, &block)
    return '' unless text

    doc = Loofah.fragment(text.gsub(/[[:space:]]/, ' '))
    doc.css('br').each { |br| br.replace ' ' }
    safe_text = strip_tags(doc.to_text.gsub(/[[:space:]]/, ' ').strip)
    unescaped = CGI.unescape_html(safe_text)

    truncate(unescaped.squeeze(' '), length: length, separator: ' ', &block)
  end
end
