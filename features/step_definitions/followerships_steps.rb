Given(/^I am following catelyn$/) do
  followership = Raddar::Followership.new
  followership.user = @user
  followership.followable = Raddar::User.find_by(name: 'catelyn')
  followership.save!
end

Given(/^catelyn starts following me$/) do
  followed = @user

  step('I am signed in as "catelyn"')
  visit raddar.user_path(followed)
  step('I click on "Seguir"')

  step("I am signed in as \"#{ followed }\"")
end

Given(/^tyrion has (\d+) followers$/) do |count|
  create_list(:followership, count.to_i, followable: Raddar::User.find_by(name: 'tyrion'))
end

Then(/^I see (\d+) (followers|followed users)$/) do |count, _|
  expect(page).to have_selector('.followership', count: count)
end

Given(/^bronn follows (\d+) users$/) do |count|
  create_list(:followership, count.to_i, user: Raddar::User.find_by(name: 'bronn'))
end
