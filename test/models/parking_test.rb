require 'test_helper'
require 'pry'

class ParkingTest < ActiveSupport::TestCase

  def setup
    @parking = parkings(:test_parking)
  end

  test "is invalid without places" do
    @parking.places = nil

    assert @parking.invalid?
    assert @parking.errors.has_key?(:places)
  end


  test "is invalid without hour_price" do
    @parking.hour_price = nil

    assert @parking.invalid?
    assert @parking.errors.has_key?(:hour_price)
  end


  test "is invalid without day_price" do
    @parking.day_price = nil

    assert @parking.invalid?
    assert @parking.errors.has_key?(:day_price)
  end

  test "is invalid without correct kind value" do
    @parking.kind = "domek"

    assert @parking.invalid?
    assert @parking.errors.has_key?(:kind)
  end

  test "is invalid without numeric hour_price" do
    @parking.hour_price = "abc"

    assert @parking.invalid?
    assert @parking.errors.has_key?(:hour_price)
  end

  test "is invalid without numeric day_price" do
    @parking.day_price = "abc"

    assert @parking.invalid?
    assert @parking.errors.has_key?(:day_price)
  end

  test "when parking is destroyed, its place rent should be finished" do
    @parking.destroy
    assert_in_delta(Time.now, @parking.place_rents.first.ends_at, 0.1)
  end

  test "should return only public parkings" do
    parkings = Parking.is_public
    assert(parkings.include? parkings(:test_parking))
    assert(parkings.exclude? parkings(:private))
  end

  test "should return only private parkings" do
    parkings = Parking.is_private
    assert(parkings.include? parkings(:private))
    assert(parkings.exclude? parkings(:test_parking))
  end

  test "should return the day price only within given range" do
    parkings = Parking.day_price_range(5, 50)
    assert(parkings.where(day_price: 50.0).present?)
    parkings = Parking.day_price_range(60, 100)
    assert(parkings.where(day_price: 50.0).blank?)
  end

  test "should return the hour price only within given range" do
    parkings = Parking.hour_price_range(5, 20)
    assert(parkings.where(hour_price: 15.0).present?)
    parkings = Parking.hour_price_range(30, 70)
    assert(parkings.where(hour_price: 15.0).blank?)
  end

  test "should return parkings in the given city" do
    parkings = Parking.given_city_parkings('Krakow')
    assert_equal 'Krakow', parkings.first.address.city
  end
end
