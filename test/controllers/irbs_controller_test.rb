require 'test_helper'

class IrbsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get irbs_new_url
    assert_response :success
  end

  test "should get index" do
    get irbs_index_url
    assert_response :success
  end

  test "should get edit" do
    get irbs_edit_url
    assert_response :success
  end

  test "should get show" do
    get irbs_show_url
    assert_response :success
  end

end
