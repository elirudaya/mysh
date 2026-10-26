require "test_helper"

class EventsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @admin = users(:admin)
    @event = events(:one)
  end

  test "guest can see index" do
    get events_url
    assert_response :success
  end

  test "guest can see published event" do
    get event_url(@event)
    assert_response :success
  end

  test "guest cannot open new event form" do
    get new_event_url
    assert_redirected_to new_user_session_url
  end

  test "admin can open new event form" do
    sign_in @admin

    get new_event_url
    assert_response :success
  end

  test "admin can create event" do
    sign_in @admin

    assert_difference("Event.count", 1) do
      post events_url, params: {
        event: {
          title: "Новая встреча",
          description: "Встреча участников проекта",
          date: 1.week.from_now,
          city: "Москва",
          address: "Центральная улица, 1",
          capacity: 20
        }
      }
    end

    assert_equal @admin.id, Event.last.user_id
    assert_redirected_to event_url(Event.last)
  end

  test "admin can edit event" do
    sign_in @admin

    get edit_event_url(@event)
    assert_response :success
  end

  test "admin can update event" do
    sign_in @admin

    patch event_url(@event), params: {
      event: {
        title: "Обновлённая встреча"
      }
    }

    assert_equal "Обновлённая встреча", @event.reload.title
    assert_redirected_to event_url(@event)
  end

  test "admin can destroy event" do
    sign_in @admin

    assert_difference("Event.count", -1) do
      delete event_url(@event)
    end

    assert_redirected_to events_url
  end

  test "regular user cannot create event" do
    sign_in users(:one)

    assert_no_difference("Event.count") do
      post events_url, params: {
        event: {
          title: "Чужая встреча",
          description: "Описание",
          date: 1.week.from_now,
          city: "Москва",
          capacity: 10
        }
      }
    end

    assert_response :redirect
  end
end
