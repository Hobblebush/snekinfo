defmodule SnekinfoWeb.WeightControllerTest do
  use SnekinfoWeb.ConnCase

  import Snekinfo.WeightsFixtures

  @create_attrs %{timestamp: ~U[2021-10-20 23:42:00Z], weight: 120.5}
  @update_attrs %{timestamp: ~U[2021-10-21 23:42:00Z], weight: 456.7}
  @invalid_attrs %{timestamp: nil, weight: nil}

  describe "index" do
    test "lists all weights", %{conn: conn} do
      conn = get(conn, Routes.weight_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Weights"
    end
  end

  describe "new weight" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.weight_path(conn, :new))
      assert html_response(conn, 200) =~ "New Weight"
    end
  end

  describe "create weight" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.weight_path(conn, :create), weight: @create_attrs)

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
    setup [:create_weight]

    test "renders form for editing chosen weight", %{conn: conn, weight: weight} do
      conn = get(conn, Routes.weight_path(conn, :edit, weight))
      assert html_response(conn, 200) =~ "Edit Weight"
    end
  end

  describe "update weight" do
    setup [:create_weight]

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
    setup [:create_weight]

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
