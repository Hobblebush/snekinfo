defmodule SnekinfoWeb.ShedControllerTest do
  use SnekinfoWeb.ConnCase

  import Snekinfo.ShedsFixtures
  import Snekinfo.SnakesFixtures

  @update_attrs %{date: ~D[2022-02-28]}
  @invalid_attrs %{date: nil}

  describe "index" do
    setup [:log_as_staff]

    test "lists all sheds", %{conn: conn} do
      conn = get(conn, Routes.shed_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Sheds"
    end
  end

  describe "new shed" do
    setup [:log_as_staff]

    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.shed_path(conn, :new))
      assert html_response(conn, 200) =~ "New Shed"
    end
  end

  describe "create shed" do
    setup [:log_as_staff]

    test "redirects to show when data is valid", %{conn: conn} do
      snake = snake_fixture()
      create_attrs = %{snake_id: snake.id, date: ~D[2022-02-27]}

      conn = post(conn, Routes.shed_path(conn, :create), shed: create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.shed_path(conn, :show, id)

      conn = get(conn, Routes.shed_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Shed"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.shed_path(conn, :create), shed: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Shed"
    end
  end

  describe "edit shed" do
    setup [:create_shed, :log_as_staff]

    test "renders form for editing chosen shed", %{conn: conn, shed: shed} do
      conn = get(conn, Routes.shed_path(conn, :edit, shed))
      assert html_response(conn, 200) =~ "Edit Shed"
    end
  end

  describe "update shed" do
    setup [:create_shed, :log_as_staff]

    test "redirects when data is valid", %{conn: conn, shed: shed} do
      conn = put(conn, Routes.shed_path(conn, :update, shed), shed: @update_attrs)
      assert redirected_to(conn) == Routes.shed_path(conn, :show, shed)

      conn = get(conn, Routes.shed_path(conn, :show, shed))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, shed: shed} do
      conn = put(conn, Routes.shed_path(conn, :update, shed), shed: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Shed"
    end
  end

  describe "delete shed" do
    setup [:create_shed, :log_as_staff]

    test "deletes chosen shed", %{conn: conn, shed: shed} do
      conn = delete(conn, Routes.shed_path(conn, :delete, shed))
      assert redirected_to(conn) == Routes.shed_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.shed_path(conn, :show, shed))
      end
    end
  end

  defp create_shed(_) do
    shed = shed_fixture()
    %{shed: shed}
  end
end
