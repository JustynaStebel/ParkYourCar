require 'test_helper'

class SessionsTest < CapybaraTest

  test "user logs in to the account" do
    visit new_session_path

    fill_in("Email", with: 'stefan123@gmail.com')
    fill_in("Password", with: 'secret123')

    click_button('Log in')

    assert has_content? 'Stefan'
  end

  test "only logged in user can see their name displayed" do
    visit parkings_path

    assert has_no_content? 'Hello, Stefan Puszcza'

    visit new_session_path

    fill_in("Email", with: 'stefan123@gmail.com')
    fill_in("Password", with: 'secret123')

    click_button('Log in')

    assert has_content? 'Hello, Stefan Puszcza'
  end

  test "user logs out" do
    visit new_session_path

    fill_in("Email", with: 'stefan123@gmail.com')
    fill_in("Password", with: 'secret123')

    click_button('Log in')

    assert has_content? 'Hello, Stefan Puszcza'

    click_on('Log out')

    assert has_no_content? 'Hello, Stefan Puszcza'
  end
end
