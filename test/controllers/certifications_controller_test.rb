require "test_helper"

class CertificationsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get certifications_index_url
    assert_response :success
  end

  test "should get show" do
    get certifications_show_url
    assert_response :success
  end
end
