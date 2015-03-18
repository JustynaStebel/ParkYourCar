require 'test_helper'

class AccountTest < ActiveSupport::TestCase

  test "is invalid without hashed password" do
    assert Account.authenticate('stefan123@gmail.com', 'secret123')
  end
end
