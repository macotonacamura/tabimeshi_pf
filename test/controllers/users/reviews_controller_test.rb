require 'test_helper'

class Users::ReviewsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get users_reviews_index_url
    assert_response :success
  end

  test "should get show" do
    get users_reviews_show_url
    assert_response :success
  end

  test "should get new" do
    get users_reviews_new_url
    assert_response :success
  end

  test "should get edit" do
    get users_reviews_edit_url
    assert_response :success
  end

end
