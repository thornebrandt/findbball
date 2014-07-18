include ApplicationHelper

def full_title(page_title)
	base_title = "Findbball"
	if page_title.empty?
		base_title
	else
		"#{base_title} | #{page_title}"
	end
end

def sign_in(member)
    visit home_path
    fill_in "Email",    with: member.email
    fill_in "Password", with: member.password
    click_button "Sign in"
    # Sign in when not using Capybara as well.
    cookies[:remember_token] = member.remember_token
end