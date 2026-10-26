require "test_helper"

class ChecklistsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @admin = users(:admin)
    @checklist = checklists(:one)
  end

  test "guest can see index" do
    get checklists_url
    assert_response :success
  end

  test "guest can see published checklist" do
    get checklist_url(@checklist)
    assert_response :success
  end

  test "guest cannot open new checklist form" do
    get new_checklist_url
    assert_redirected_to new_user_session_url
  end

  test "admin can open new checklist form" do
    sign_in @admin

    get new_checklist_url
    assert_response :success
  end

  test "admin can create checklist" do
    sign_in @admin

    assert_difference("Checklist.count", 1) do
      post checklists_url, params: {
        checklist: {
          title: "Новый гайд",
          country: "Россия",
          category: "Документы",
          content: "Полезная информация о документах"
        }
      }
    end

    assert_equal @admin.id, Checklist.last.user_id
    assert_redirected_to checklist_url(Checklist.last)
  end

  test "admin can edit checklist" do
    sign_in @admin

    get edit_checklist_url(@checklist)
    assert_response :success
  end

  test "admin can update checklist" do
    sign_in @admin

    patch checklist_url(@checklist), params: {
      checklist: {
        title: "Обновлённый гайд"
      }
    }

    assert_equal "Обновлённый гайд", @checklist.reload.title
    assert_redirected_to checklist_url(@checklist)
  end

  test "admin can destroy checklist" do
    sign_in @admin

    assert_difference("Checklist.count", -1) do
      delete checklist_url(@checklist)
    end

    assert_redirected_to checklists_url
  end

  test "regular user cannot create checklist" do
    sign_in users(:one)

    assert_no_difference("Checklist.count") do
      post checklists_url, params: {
        checklist: {
          title: "Чужой гайд",
          country: "Россия",
          category: "Документы",
          content: "Текст"
        }
      }
    end

    assert_response :redirect
  end
end
