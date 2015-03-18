require 'test_helper'

class PlaceRentsTest < CapybaraTest

  def setup
    @parking = parkings(:test_parking)
    @place_rent = place_rents(:test_place_rent)
    @current_person = people(:stefan_puszcza)
  end

  def log_in
    visit new_session_path

    fill_in("Email", with: 'stefan123@gmail.com')
    fill_in("Password", with: 'secret123')

    click_button('Log in')

    assert has_content? 'Stefan'
  end

  test "user rents a place on a parking" do
    log_in

    visit parkings_path
    assert has_content? 'Parkings'

    within("tr.parking-#{parkings(:test_parking).id}") do
      click_link('Rent a place')
    end

    select('honda', from: 'Car')

    click_on('Create Place rent')

    assert has_content? 'Place rented!'
  end

  test "user checks if rent price is displayed" do
    log_in

    visit place_rents_path
    assert has_content? 'Price'
    assert has_content? '9.99'
  end

end
