Given(/^I have a Facebook account with the following information:$/) do |table|
  info = table.hashes.first

  OmniAuth.config.mock_auth[:facebook] = {
    provider: 'facebook',
    uid: '12345',
    info: {
      email: info[:email],
      name: info[:name],
      location: info[:location],
      description: info[:bio],
      image: info[:image].present? ? "http://facebook.com/#{ info[:image] }" : nil,
      urls: { Facebook: 'http://facebook.com/my_profile' }
    },
    credentials: {
      token: 'abcd',
      secret: 'abcdsecret'
    },
    extra: {
      raw_info: {
        birthday: info[:birthday],
        gender:   info[:gender]
      }
    }
  }

  stub_request(:any, /facebook.com/).
    to_return(
      status: 200,
      body: File.read(Rails.root.to_s + '/spec/fixtures/image.jpg')
    )
end

Given(/^I've connected my (.*?) account$/) do |provider|
  create(:external_account, provider: provider.downcase, user: @user)
end
