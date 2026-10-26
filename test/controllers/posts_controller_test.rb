require "test_helper"

class PostsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:one)
    @post = posts(:one)
  end

  test "should get index" do
    get posts_url
    assert_response :success
  end

  test "should show approved post to guest" do
    get post_url(@post)
    assert_response :success
  end

  test "guest should be redirected to sign in" do
    get new_post_url
    assert_redirected_to new_user_session_url
  end

  test "should get new when signed in" do
    sign_in @user

    get new_post_url
    assert_response :success
  end

  test "should create pending post" do
    sign_in @user

    assert_difference("Post.count", 1) do
      post posts_url, params: {
        post: {
          title: "Новый пост",
          body: "Текст нового поста"
        }
      }
    end

    assert_equal "pending", Post.last.status
    assert_equal @user.id, Post.last.user_id
    assert_redirected_to mine_posts_path
  end

  test "should get edit for own post" do
    sign_in @user

    get edit_post_url(@post)
    assert_response :success
  end

  test "should update own post and send to moderation" do
    sign_in @user

    patch post_url(@post), params: {
      post: {
        title: "Изменённый заголовок",
        body: "Изменённый текст"
      }
    }

    assert_equal "pending", @post.reload.status
    assert_equal "Изменённый заголовок", @post.title
    assert_redirected_to mine_posts_path
  end

  test "should destroy own post" do
    sign_in @user

    assert_difference("Post.count", -1) do
      delete post_url(@post)
    end

    assert_redirected_to mine_posts_path
  end

  test "user cannot edit another user's post" do
    sign_in users(:two)

    get edit_post_url(@post)

    assert_response :redirect
  end
end
