require 'rails_helper'

describe Raddar::ApplicationHelper, type: :helper do
  describe '#simple_text' do
    it 'adds <br> tags to line breaks' do
      text = "Line One\nLine Two"

      expect(helper.simple_text(text)).to eq("<p>Line One\n<br>Line Two</p>")
    end

    it 'adds <p> tags to double linke breaks' do
      text = "Line One\n\nLine Two"

      expect(helper.simple_text(text)).to eq("<p>Line One</p>\n\n<p>Line Two</p>")
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
        '<p>Visit <a target="_blank" href="http://radicaos.com">http://radicaos.com</a></p>'
      )
    end

    it 'autolinks mentions' do
      create(:user, name: 'volmer')

      text = 'Welcome @volmer'

      expect(helper.simple_text(text)).to eq(
        '<p>Welcome <a href="/users/volmer">@volmer</a></p>'
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
  end

  describe '#autolink_mentions' do
    it 'replace a mention with a link to the user profile' do
      create(:user, name: 'volmer')
      create(:user, name: 'octocat')

      text = 'Welcome, @volmer'
      expect(helper.autolink_mentions(text)).to eq('Welcome, <a href="/users/volmer">@volmer</a>')

      text = 'Welcome @volmer and @octocat'
      expect(helper.autolink_mentions(text)).to eq('Welcome <a href="/users/volmer">@volmer</a> and <a href="/users/octocat">@octocat</a>')

      text = '@volmer, read this'
      expect(helper.autolink_mentions(text)).to eq('<a href="/users/volmer">@volmer</a>, read this')

      text = '@volmer.'
      expect(helper.autolink_mentions(text)).to eq('<a href="/users/volmer">@volmer</a>.')

      text = 'Welcome, @volmer!!'
      expect(helper.autolink_mentions(text)).to eq('Welcome, <a href="/users/volmer">@volmer</a>!!')

      text = '@volmer, @volmer'
      expect(helper.autolink_mentions(text)).to eq('<a href="/users/volmer">@volmer</a>, <a href="/users/volmer">@volmer</a>')

      text = '@volmer, @volmerius'
      expect(helper.autolink_mentions(text)).to eq('<a href="/users/volmer">@volmer</a>, @volmerius')

      text = 'welcome@volmer'
      expect(helper.autolink_mentions(text)).to eq('welcome@volmer')

      text = 'Welcome, @VOLMER'
      expect(helper.autolink_mentions(text)).to eq('Welcome, <a href="/users/volmer">@VOLMER</a>')

      text = 'Welcome,@VOLMER'
      expect(helper.autolink_mentions(text)).to eq('Welcome,<a href="/users/volmer">@VOLMER</a>')
    end

    it 'does nothing if user does not exist' do
      text = 'Welcome, @volmer'

      expect(helper.autolink_mentions(text)).to eq(text)
    end

    it 'is blank if nil is given' do
      expect(helper.autolink_mentions(nil)).to eq('')
    end
  end

  describe '#mentioned_users' do
    let!(:user_1) { create(:user, name: 'volmer') }
    let!(:user_2) { create(:user, name: 'octocat') }

    it 'returns all users mentioned in the given string' do
      text = 'Welcome, @volmer'
      expect(helper.mentioned_users(text)).to contain_exactly(user_1)

      text = 'Welcome @volmer and @octocat'
      expect(helper.mentioned_users(text)).to contain_exactly(user_1, user_2)

      text = '@volmer, read this'
      expect(helper.mentioned_users(text)).to contain_exactly(user_1)

      text = '@volmer.'
      expect(helper.mentioned_users(text)).to contain_exactly(user_1)

      text = 'Welcome, @volmer!!'
      expect(helper.mentioned_users(text)).to contain_exactly(user_1)

      text = '@volmer, @volmerius'
      expect(helper.mentioned_users(text)).to contain_exactly(user_1)

      text = 'welcome@volmer'
      expect(helper.mentioned_users(text)).to be_empty

      text = 'Welcome, @VOLMER'
      expect(helper.mentioned_users(text)).to contain_exactly(user_1)

      text = 'Welcome,@VOLMER'
      expect(helper.mentioned_users(text)).to contain_exactly(user_1)
    end

    it 'does not return the same user twice' do
      text = 'Hey @volmer, @volmer'
      expect(helper.mentioned_users(text)).to contain_exactly(user_1)
    end

    it 'is empty if user does not exist' do
      text = 'Welcome, @volmerius'

      expect(helper.mentioned_users(text)).to be_empty
    end

    it 'is empty if nil is given' do
      expect(helper.mentioned_users(nil)).to be_empty
    end
  end
end
