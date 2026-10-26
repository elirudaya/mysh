require "test_helper"

class ProfilesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @profile = profiles(:one)
    @user = @profile.user
  end

  test "guest can see profile" do
    get profile_url(@profile)

    assert_response :success
  end

  test "guest cannot edit profile" do
    get edit_profile_url(@profile)

    assert_redirected_to new_user_session_url
  end

  test "owner can see profile" do
    sign_in @user

    get profile_url(@profile)

    assert_response :success
  end

  test "owner can open edit page" do
    sign_in @user

    get edit_profile_url(@profile)

    assert_response :success
  end

  test "owner can update profile" do
    sign_in @user

    patch profile_url(@profile), params: {
      profile: {
        name: "Новое имя",
        age: 20,
        origin_country: "Россия",
        origin_city: "Москва",
        current_country: "Нидерланды",
        current_city: "Амстердам",
        social: "@example"
      }
    }

    assert_redirected_to profile_url(@profile)

    @profile.reload

    assert_equal "Новое имя", @profile.name
    assert_equal "Амстердам", @profile.current_city
    assert_equal "@example", @profile.social
  end

  test "user cannot edit another user's profile" do
    sign_in users(:two)

    get edit_profile_url(@profile)

    assert_response :redirect
  end

  test "user cannot update another user's profile" do
    sign_in users(:two)

    original_name = @profile.name

    patch profile_url(@profile), params: {
      profile: {
        name: "Чужое изменение"
      }
    }

    assert_response :redirect
    assert_equal original_name, @profile.reload.name
  end

  test "profile update cannot change owner" do
    sign_in @user

    patch profile_url(@profile), params: {
      profile: {
        name: "Мой профиль",
        user_id: users(:two).id
      }
    }

    assert_redirected_to profile_url(@profile)
    assert_equal @user.id, @profile.reload.user_id
  end
end
