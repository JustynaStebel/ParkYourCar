require 'test_helper'

class CarsTest < CapybaraTest

  def fill_form
    fill_in("Registration number", with: "12345")
    fill_in("Model", with: "test model")
  end

  def log_in
    visit new_session_path

    fill_in("Email", with: 'stefan123@gmail.com')
    fill_in("Password", with: 'secret123')

    click_button('Log in')

    assert has_content? 'Stefan'
  end

  test "user opens cars index" do
    log_in

    visit cars_path

    assert has_content? 'Cars'
  end

  test "user opens car details" do
    log_in

    visit cars_path

    click_on('show')

    assert has_content? 'Registration number'
    assert has_content? 'Model'
    assert has_content? 'Back to cars'
  end

  test "user adds a new car" do
    log_in

    visit cars_path

    click_on('New car')

    fill_form

    click_button('Create Car')

    assert has_content? 'Registration number: 12345'
  end

  test "user edits a car" do
    log_in

    visit cars_path

    click_on('edit')

    assert has_content? 'Updating your car'

    fill_form

    click_button('Update Car')
  end

  test "user removes a car" do
    log_in

    visit cars_path

    click_on('destroy')

    assert has_no_content? 'honda'
  end
end

