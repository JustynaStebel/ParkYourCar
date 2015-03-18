require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  include ApplicationHelper

  test "application helper displays controller in a page title" do
    params[:controller] = "bla_bla"
    assert_equal "Bla bla", title
  end
end
