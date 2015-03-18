require 'test_helper'

class PlaceRentTest < ActiveSupport::TestCase

  def setup
    @place = place_rents(:test_place_rent)
  end

  test "is invalid without starts_at" do
    @place.starts_at = nil

    assert @place.invalid?
    assert @place.errors.has_key?(:starts_at)
  end

  test "is invalid without ends_at" do
    @place.ends_at = nil

    assert @place.invalid?
    assert @place.errors.has_key?(:ends_at)
  end

  test "is invalid without parking" do
    @place.parking = nil

    assert @place.invalid?
    assert @place.errors.has_key?(:parking)
  end

  test "is invalid without car" do
    @place.car = nil

    assert @place.invalid?
    assert @place.errors.has_key?(:car)
  end

  test "price for 0 seconds should be 0" do
    new_place = PlaceRent.create(car: cars(:test_car), parking: parkings(:test_parking), starts_at: place_rents(:test_place_rent).starts_at, ends_at: place_rents(:test_place_rent).starts_at)
    assert_equal(0, new_place.price)
  end

  test "price for 1 hour should be 15.0" do
    new_place = PlaceRent.create(car: cars(:test_car), parking: parkings(:test_parking), starts_at: place_rents(:test_place_rent).starts_at, ends_at: place_rents(:test_place_rent).starts_at + 1.hour)
    assert_equal(15.0, new_place.price)
  end

  test "price for 61 minutes should be 30.0" do
    new_place = PlaceRent.create(car: cars(:test_car), parking: parkings(:test_parking), starts_at: place_rents(:test_place_rent).starts_at, ends_at: place_rents(:test_place_rent).starts_at + 61.minutes)
    assert_equal(30.0, new_place.price)
  end

  test "price for 23 hours should be 15.0 * 23" do
    new_place = PlaceRent.create(car: cars(:test_car), parking: parkings(:test_parking), starts_at: place_rents(:test_place_rent).starts_at, ends_at: place_rents(:test_place_rent).starts_at + 23.hours)
    assert_equal(15 * 23, new_place.price)
  end

  test "price for 24 hours should be 50" do
    new_place = PlaceRent.create(car: cars(:test_car), parking: parkings(:test_parking), starts_at: place_rents(:test_place_rent).starts_at, ends_at: place_rents(:test_place_rent).starts_at + 24.hours)
    assert_equal(50, new_place.price)
  end

  test "price for 36 hours should be 230" do
    new_place = PlaceRent.create(car: cars(:test_car), parking: parkings(:test_parking), starts_at: place_rents(:test_place_rent).starts_at, ends_at: place_rents(:test_place_rent).starts_at + 36.hours)
    assert_equal(230, new_place.price)
  end

  test "old price should not change when parking price is modified" do
    old_price = @place.price
    @place.parking.day_price = 100
    @place.save
    assert_equal(old_price, @place.price)
  end
end
