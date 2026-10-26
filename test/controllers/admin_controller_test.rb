require "test_helper"

class AdminControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @admin = users(:admin)
    @user = users(:one)
  end

  test "admin can open dashboard" do
    sign_in @admin

    get admin_url
    assert_response :success
  end

  test "admin can open users page" do
    sign_in @admin

    get admin_users_url
    assert_response :success
  end

  test "admin can open posts moderation" do
    sign_in @admin

    get admin_posts_url
    assert_response :success
  end

  test "admin can open events moderation" do
    sign_in @admin

    get admin_events_url
    assert_response :success
  end

  test "admin can open guides moderation" do
    sign_in @admin

    get admin_guides_url
    assert_response :success
  end

  test "admin can open places moderation" do
    sign_in @admin

    get admin_places_url
    assert_response :success
  end

  test "guest cannot open admin dashboard" do
    get admin_url

    assert_redirected_to new_user_session_url
  end

  test "regular user cannot open admin dashboard" do
    sign_in @user

    get admin_url

    assert_redirected_to home_url
  end

  test "regular user cannot open users page" do
    sign_in @user

    get admin_users_url

    assert_redirected_to home_url
  end

  test "regular user cannot open posts moderation" do
    sign_in @user

    get admin_posts_url

    assert_redirected_to home_url
  end
end
