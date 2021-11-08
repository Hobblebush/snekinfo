defmodule SnekinfoWeb.LitterControllerTest do
  use SnekinfoWeb.ConnCase

  import Snekinfo.LittersFixtures
  alias Snekinfo.SnakesFixtures

  @create_attrs %{born: ~D[2021-10-20], stills: 0, slugs: 4}
  @update_attrs %{born: ~D[2021-10-21], stills: 1, slugs: 4}
  @invalid_attrs %{born: "goat"}

  describe "index" do
    test "lists all litters", %{conn: conn} do
      conn = get(conn, Routes.litter_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Litters"
    end
  end

  describe "new litter" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.litter_path(conn, :new))
      assert html_response(conn, 200) =~ "New Litter"
    end
  end

  describe "create litter" do
    test "redirects to show when data is valid", %{conn: conn} do
      mother = SnakesFixtures.snake_fixture()

      litter_attrs = Map.put(@create_attrs, :mother_id, mother.id)
      conn = post(conn, Routes.litter_path(conn, :create), litter: litter_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.litter_path(conn, :show, id)

      conn = get(conn, Routes.litter_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Litter"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.litter_path(conn, :create), litter: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Litter"
    end
  end

  describe "edit litter" do
    setup [:create_litter]

    test "renders form for editing chosen litter", %{conn: conn, litter: litter} do
      conn = get(conn, Routes.litter_path(conn, :edit, litter))
      assert html_response(conn, 200) =~ "Edit Litter"
    end
  end

  describe "update litter" do
    setup [:create_litter]

    test "redirects when data is valid", %{conn: conn, litter: litter} do
      conn = put(conn, Routes.litter_path(conn, :update, litter), litter: @update_attrs)
      assert redirected_to(conn) == Routes.litter_path(conn, :show, litter)

      conn = get(conn, Routes.litter_path(conn, :show, litter))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, litter: litter} do
      conn = put(conn, Routes.litter_path(conn, :update, litter), litter: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Litter"
    end
  end

  describe "delete litter" do
    setup [:create_litter]

    test "deletes chosen litter", %{conn: conn, litter: litter} do
      conn = delete(conn, Routes.litter_path(conn, :delete, litter))
      assert redirected_to(conn) == Routes.litter_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.litter_path(conn, :show, litter))
      end
    end
  end

  defp create_litter(_) do
    litter = litter_fixture()
    %{litter: litter}
  end
end
