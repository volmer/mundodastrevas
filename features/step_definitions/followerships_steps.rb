Given(/^I am following catelyn$/) do
  followership = Followership.new
  followership.user = @user
  followership.followable = User.find_by(name: 'catelyn')
  followership.save!
end

Given(/^catelyn starts following me$/) do
  followed = @user

  step('I am signed in as "catelyn"')
  visit user_path(followed)
  step('I click on "Seguir"')

  step("I am signed in as \"#{ followed }\"")
end

Given(/^tyrion has (\d+) followers$/) do |count|
  create_list(:followership, count.to_i, followable: User.find_by(name: 'tyrion'))
end

Then(/^I see (\d+) (followers|followed users)$/) do |count, _|
  expect(page).to have_selector('.followership', count: count)
end

Given(/^bronn follows (\d+) users$/) do |count|
  create_list(:followership, count.to_i, user: User.find_by(name: 'bronn'))
end
