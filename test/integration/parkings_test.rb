require 'test_helper'

class ParkingsTest < CapybaraTest

  def setup
    @parking = parkings(:test_parking)
  end

  test "user opens parkings index" do
    visit parkings_path
    assert has_content? 'Parkings'
  end

  test "user opens parking details" do
    visit parking_path(@parking)

    assert has_content? 'Krakow'
    assert has_content? 'Back to parkings'
    assert has_content? 'Places'
  end

  test "user adds a new parking" do
    visit new_parking_path

    assert has_content? 'Adding new parking'
    assert has_content? 'Choose...'

    fill_in("City", with: 'Krakow')
    fill_in("Street", with: 'Bracka')
    fill_in("Zip code", with: '31-303')

    select('outdoor', from: 'Kind')

    fill_in("Places", with: '150')
    fill_in("Hour price", with: '15')
    fill_in("Day price", with: '50')

    click_button('Create Parking')

    assert has_content? 'Bracka'
    assert has_content? 'Places: 150'
    assert has_content? 'Day price: 50.0'
  end

  test "user edits a parking" do
    visit edit_parking_path(@parking)

    assert has_content? 'Updating your parking'

    fill_in("City", with: 'Berlin')

    click_button('Update Parking')

    assert_equal(parking_path(@parking), current_path)

    assert has_content? 'Berlin'
  end

  test "user removes a parking" do
    visit parkings_path
    within("tr.parking-#{parkings(:test_parking).id}") do
      click_link('Destroy')
    end
    assert has_no_content? 'Berlin'
  end

  test "user searches for a parking" do
    visit parkings_path

    fill_in("City:", with: 'Krakow')

    click_on('Search')

    assert has_content? 'Krakow'
  end

end
