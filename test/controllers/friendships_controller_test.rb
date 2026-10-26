require "test_helper"

class FriendshipsControllerTest < ActionDispatch::IntegrationTest
  test "guest cannot open friendships index" do
    get friendships_url

    assert_redirected_to new_user_session_url
  end

  test "guest cannot open new friendship form" do
    get new_friendship_url

    assert_redirected_to new_user_session_url
  end

  test "guest cannot open friendship" do
    get friendship_url(friendships(:one))

    assert_redirected_to new_user_session_url
  end

  test "guest cannot create friendship" do
    assert_no_difference("Friendship.count") do
      post friendships_url, params: {
        friendship: {
          friend_email: "friend@example.com",
          status: "pending"
        }
      }
    end

    assert_redirected_to new_user_session_url
  end

  test "guest cannot delete friendship" do
    assert_no_difference("Friendship.count") do
      delete friendship_url(friendships(:one))
    end

    assert_redirected_to new_user_session_url
  end
end
