defmodule SnekinfoWeb.WeightControllerTest do
  use SnekinfoWeb.ConnCase

  import Snekinfo.WeightsFixtures
  alias Snekinfo.SnakesFixtures

  @create_attrs %{date: ~D[2021-10-20], weight: 120.5}
  @update_attrs %{date: ~D[2021-10-21], weight: 456.7}
  @invalid_attrs %{timestamp: "goat", weight: -7.5}

  describe "index" do
    setup [:log_as_staff]

    test "lists all weights", %{conn: conn} do
      conn = get(conn, Routes.weight_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Weights"
    end
  end

  describe "new weight" do
    setup [:log_as_staff]

    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.weight_path(conn, :new))
      assert html_response(conn, 200) =~ "New Weight"
    end
  end

  describe "create weight" do
    setup [:log_as_staff]

    test "redirects to show when data is valid", %{conn: conn} do
      snake = SnakesFixtures.snake_fixture()
      weight_attrs = Map.put(@create_attrs, :snake_id, snake.id)

      conn = post(conn, Routes.weight_path(conn, :create), weight: weight_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.weight_path(conn, :show, id)

      conn = get(conn, Routes.weight_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Weight"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.weight_path(conn, :create), weight: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Weight"
    end
  end

  describe "edit weight" do
    setup [:create_weight, :log_as_staff]

    test "renders form for editing chosen weight", %{conn: conn, weight: weight} do
      conn = get(conn, Routes.weight_path(conn, :edit, weight))
      assert html_response(conn, 200) =~ "Edit Weight"
    end
  end

  describe "update weight" do
    setup [:create_weight, :log_as_staff]

    test "redirects when data is valid", %{conn: conn, weight: weight} do
      conn = put(conn, Routes.weight_path(conn, :update, weight), weight: @update_attrs)
      assert redirected_to(conn) == Routes.weight_path(conn, :show, weight)

      conn = get(conn, Routes.weight_path(conn, :show, weight))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, weight: weight} do
      conn = put(conn, Routes.weight_path(conn, :update, weight), weight: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Weight"
    end
  end

  describe "delete weight" do
    setup [:create_weight, :log_as_staff]

    test "deletes chosen weight", %{conn: conn, weight: weight} do
      conn = delete(conn, Routes.weight_path(conn, :delete, weight))
      assert redirected_to(conn) == Routes.weight_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.weight_path(conn, :show, weight))
      end
    end
  end

  defp create_weight(_) do
    weight = weight_fixture()
    %{weight: weight}
  end
end
