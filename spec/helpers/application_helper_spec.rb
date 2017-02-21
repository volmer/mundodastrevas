require 'rails_helper'

describe ApplicationHelper, type: :helper do
  describe '#simple_text' do
    it 'adds <br> tags to line breaks' do
      text = "Line One\nLine Two"

      expect(helper.simple_text(text)).to eq("<p>Line One\n<br>Line Two</p>")
    end

    it 'adds <p> tags to double linke breaks' do
      text = "Line One\n\nLine Two"

      expect(helper.simple_text(text)).to eq(
        "<p>Line One</p>\n\n<p>Line Two</p>"
      )
    end

    it 'removes any tags but <br> and <p>' do
      text = '<p>Example<br><img></p>'

      expect(helper.simple_text(text)).to include('<p>')

      expect(helper.simple_text(text)).to include('<br>')

      expect(helper.simple_text(text)).not_to include('<img>')
    end

    it 'removes any attributes' do
      text = '<p class="alert">Example</p>'

      expect(helper.simple_text(text)).not_to include('class')
    end

    it 'autolinks urls' do
      text = 'Visit http://radicaos.com'

      expect(helper.simple_text(text)).to eq(
        '<p>Visit <a target="_blank" '\
        'href="http://radicaos.com">http://radicaos.com</a></p>'
      )
    end
  end

  describe '#truncate_rich' do
    it 'removes all tags from the text' do
      text = '<strong>This text</strong> <img/>contains tags.'

      expect(helper.truncate_rich(text)).to eq('This text contains tags.')
    end

    it 'replaces br tags with whitespaces' do
      text = 'white<br>space'
      expect(helper.truncate_rich(text)).to eq('white space')

      text = 'white<br/>space'
      expect(helper.truncate_rich(text)).to eq('white space')

      text = 'white<br />space'
      expect(helper.truncate_rich(text)).to eq('white space')
    end

    it 'adds space between paragraphs' do
      text = '<p>white</p><p>space</p>'
      expect(helper.truncate_rich(text)).to eq('white space')
    end

    it 'truncates text in 300 characters by default' do
      text = 'Night gathers, and now my watch begins. It shall not end until '\
        'my death. I shall take no wife, hold no lands, father no children. I '\
        'shall wear no crowns and win no glory. I shall live and die at my '\
        'post. I am the sword in the darkness. I am the watcher on the walls. '\
        'I am the fire that burns against the cold, the light that brings the '\
        'dawn, the horn that wakes the sleepers, the shield that guards the '\
        "realms of men. I pledge my life and honor to the Night's Watch, for "\
        'this night and all the nights to come.'

      expect(helper.truncate_rich(text))
        .to eq(
          'Night gathers, and now my watch begins. It shall not end until my '\
          'death. I shall take no wife, hold no lands, father no children. I '\
          'shall wear no crowns and win no glory. I shall live and die at my '\
          'post. I am the sword in the darkness. I am the watcher on the '\
          'walls. I am the fire that burns...'
        )
    end

    it 'truncates text with te given length' do
      text = 'This is a sample text with more than 50 characters.'

      expect(helper.truncate_rich(text, length: 50))
        .to eq('This is a sample text with more than 50...')
    end

    it 'ends text with the given block' do
      text = 'This is a sample text with more than 50 characters.'

      expect(helper.truncate_rich(text, length: 50) { ' (truncated)' })
        .to eq('This is a sample text with more than 50... (truncated)')
    end

    it 'preservers full words' do
      text = "This\nis\na\nsample\ntext\nwith\nmore\nthan\n17\ncharacters."

      expect(helper.truncate_rich(text, length: 17))
        .to eq('This is a...')
    end

    it 'squeezes whitespaces' do
      text = 'white          space'
      expect(helper.truncate_rich(text)).to eq('white space')

      text = 'white <br/> space'
      expect(helper.truncate_rich(text)).to eq('white space')

      text = 'white &nbsp; space'
      expect(helper.truncate_rich(text)).to eq('white space')

      text = "white \n space"
      expect(helper.truncate_rich(text)).to eq('white space')

      text = "white \r space"
      expect(helper.truncate_rich(text)).to eq('white space')
    end

    it 'is blank if nil is given' do
      expect(helper.truncate_rich(nil)).to eq('')
    end

    it 'handles special characters' do
      expect(helper.truncate_rich('This is a "quoted" text.')).to eq(
        'This is a &quot;quoted&quot; text.'
      )
    end
  end
end
