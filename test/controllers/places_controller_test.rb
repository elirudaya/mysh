require "test_helper"

class PlacesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @admin = users(:admin)
    @place = places(:one)
  end

  test "guest can see index" do
    get places_url
    assert_response :success
  end

  test "guest can see published place" do
    get place_url(@place)
    assert_response :success
  end

  test "guest cannot open new place form" do
    get new_place_url
    assert_redirected_to new_user_session_url
  end

  test "admin can open new place form" do
    sign_in @admin

    get new_place_url
    assert_response :success
  end

  test "admin can create place" do
    sign_in @admin

    assert_difference("Place.count", 1) do
      post places_url, params: {
        place: {
          name: "Новое место",
          description: "Описание интересного места",
          city: "Москва",
          address: "Центральная улица, 1",
          category: "Кафе"
        }
      }
    end

    assert_equal @admin.id, Place.last.user_id
    assert_redirected_to place_url(Place.last)
  end

  test "admin can edit place" do
    sign_in @admin

    get edit_place_url(@place)
    assert_response :success
  end

  test "admin can update place" do
    sign_in @admin

    patch place_url(@place), params: {
      place: {
        name: "Обновлённое место"
      }
    }

    assert_equal "Обновлённое место", @place.reload.name
    assert_redirected_to place_url(@place)
  end

  test "admin can destroy place" do
    sign_in @admin

    assert_difference("Place.count", -1) do
      delete place_url(@place)
    end

    assert_redirected_to places_url
  end

  test "regular user cannot create place" do
    sign_in users(:one)

    assert_no_difference("Place.count") do
      post places_url, params: {
        place: {
          name: "Чужое место",
          description: "Описание",
          city: "Москва",
          address: "Улица, 1",
          category: "Кафе"
        }
      }
    end

    assert_response :redirect
  end
end
