include ApplicationHelper

RSpec::Matchers.define :have_error_message do |message| # this is a custom RSpec matcher
  match do |page|
    page.should have_selector('div.alert.alert-error', text: message)
  end
end

RSpec::Matchers.define :have_selector_error  do # this is a custom RSpec matcher
  match do |page|
    page.should_not have_selector('div.alert.alert-error')
  end
end

RSpec::Matchers.define :have_success_message do |message| # this is a custom RSpec matcher
  match do |page|
    page.should have_selector('div.alert.alert-success', text: message)
  end
end

RSpec::Matchers.define :have_selector_h1 do |message| # this is a custom RSpec matcher 
  match do |page|
  page.should have_selector('h1', text: message)
  end
end

RSpec::Matchers.define :have_selector_title do |message| # this is a custom RSpec matcher 
  match do |page|
  page.should have_selector('title', text: full_title(message))
  end
end

Spec::Matchers.define :have_content_message do |message| # this is a custom RSpec matcher 
  match do |page|
  page.should have_content(message)
  end
end

def valid_signin(user)
  fill_in "Email", with: user.email
  fill_in "Password", with: user.password
  click_button "Sign in"
end

def fill_user_information()
  fill_in "Name",         with: "Example User"
  fill_in "Email",        with: "user@example.com"
  fill_in "Password",     with: "foobar"
  fill_in "Confirmation", with: "foobar"
end    

