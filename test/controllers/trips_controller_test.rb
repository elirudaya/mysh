require "test_helper"

class TripsControllerTest < ActionDispatch::IntegrationTest
  test "guest can open trips index if permitted" do
    get trips_url

    assert_response :success
  end

  test "guest cannot create trip" do
    assert_no_difference("Trip.count") do
      post trips_url, params: {
        trip: {
          origin_city: "Москва",
          destination_city: "Санкт-Петербург",
          start_date: Date.current,
          end_date: Date.tomorrow,
          trip_type: "personal",
          transport: "train"
        }
      }
    end

    assert_response :redirect
  end

  test "guest cannot update trip" do
    trip = trips(:one)
    original_city = trip.destination_city

    patch trip_url(trip), params: {
      trip: {
        destination_city: "Казань"
      }
    }

    assert_response :redirect
    assert_equal original_city, trip.reload.destination_city
  end

  test "guest cannot delete trip" do
    assert_no_difference("Trip.count") do
      delete trip_url(trips(:one))
    end

    assert_response :redirect
  end
end
