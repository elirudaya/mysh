require "test_helper"

class PostsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:one)
    @post = posts(:one)
  end

  test "should redirect guest from index to sign in" do
    get posts_url

    assert_redirected_to new_user_session_url
  end

  test "should redirect guest from post to sign in" do
    get post_url(@post)

    assert_redirected_to new_user_session_url
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

  test "should create approved post" do
    sign_in @user

    assert_difference("Post.count", 1) do
      post posts_url, params: {
        post: {
          title: "Новый пост",
          body: "Текст нового поста"
        }
      }
    end

    assert_equal "approved", Post.last.status
    assert_equal @user.id, Post.last.user_id
    assert_redirected_to post_url(Post.last)
  end

  test "should get edit for own post" do
    sign_in @user

    get edit_post_url(@post)
    assert_response :success
  end

  test "should update own post" do
    sign_in @user

    patch post_url(@post), params: {
      post: {
        title: "Изменённый заголовок",
        body: "Изменённый текст"
      }
    }

    assert_equal "approved", @post.reload.status
    assert_equal "Изменённый заголовок", @post.title
    assert_redirected_to post_url(@post)
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
