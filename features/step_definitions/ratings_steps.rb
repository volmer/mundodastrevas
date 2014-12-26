When(/^I check the post as "(.*?)"$/) do |value|
  within('.zine-post') do
    find(".btn.#{ value }").click
  end
end

When(/^I check the comment as "(.*?)"$/) do |value|
  within('.zine-comment') do
    find(".btn.#{ value }").click
  end
end

Then(/^I see "(.*?)" in the "(.*?)" post counter$/) do |count, type|
  within('.zine-post') do
    button = find(".btn.#{ type }")

    expect(button).to have_content(count)
  end
end

Then(/^I see "(.*?)" in the "(.*?)" comment counter$/) do |count, type|
  within('.zine-comment') do
    button = find(".btn.#{ type }")

    expect(button).to have_content(count)
  end
end
