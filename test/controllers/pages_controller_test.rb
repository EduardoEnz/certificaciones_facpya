require "test_helper"

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "should get nosotros" do
    get pages_nosotros_url
    assert_response :success
  end

  test "should get testimonios" do
    get pages_testimonios_url
    assert_response :success
  end

  test "should get faq" do
    get pages_faq_url
    assert_response :success
  end
end
