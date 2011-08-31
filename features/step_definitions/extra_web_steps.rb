When /^I visit "([^"]*)"$/ do |path|
  visit path
end

Then /^I should see "([^"]*)" with title "([^"]*)"$/ do |text, title|
  page.should have_content(text)
  page.should have_selector 'title', text: title
end