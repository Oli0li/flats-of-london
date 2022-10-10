require "application_system_test_case"

class FlatsTest < ApplicationSystemTestCase
  test "visiting the index" do
    visit root_path

    assert_selector "h1", text: "Find the perfect flat for your stay in London"
  end
end
