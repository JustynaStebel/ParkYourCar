require 'test_helper'

class PersonTest < ActiveSupport::TestCase
  def setup
    @person = people(:stefan_puszcza)
  end

  test "is invalid without first_name" do 
    @person.first_name = nil

    assert @person.invalid?
    assert @person.errors.has_key?(:first_name)
  end
end
