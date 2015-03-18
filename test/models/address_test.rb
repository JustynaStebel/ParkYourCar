require 'test_helper'

class AddressTest < ActiveSupport::TestCase
  def setup
    @address = addresses(:krakow)
  end

  test "is invalid without city" do 
    @address.city = nil

    assert @address.invalid?
    assert @address.errors.has_key?(:city)
  end

  test "is invalid without street" do 
    @address.street = nil

    assert @address.invalid?
    assert @address.errors.has_key?(:street)
  end

  test "is invalid without zip_code" do 
    @address.zip_code = nil

    assert @address.invalid?
    assert @address.errors.has_key?(:zip_code)
  end

  test "is invalid without proper zip_code format" do
    @address.zip_code = "1a34h6"

    assert @address.invalid?
    @address.errors[:zip_code]
  end
end
