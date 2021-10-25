defmodule SnekinfoWeb.Snake_traitControllerTest do
  use SnekinfoWeb.ConnCase

  import Snekinfo.Snake_traitsFixtures

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  describe "index" do
    test "lists all snake_traits", %{conn: conn} do
      conn = get(conn, Routes.snake_trait_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Snake traits"
    end
  end

  describe "new snake_trait" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.snake_trait_path(conn, :new))
      assert html_response(conn, 200) =~ "New Snake trait"
    end
  end

  describe "create snake_trait" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.snake_trait_path(conn, :create), snake_trait: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.snake_trait_path(conn, :show, id)

      conn = get(conn, Routes.snake_trait_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Snake trait"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.snake_trait_path(conn, :create), snake_trait: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Snake trait"
    end
  end

  describe "edit snake_trait" do
    setup [:create_snake_trait]

    test "renders form for editing chosen snake_trait", %{conn: conn, snake_trait: snake_trait} do
      conn = get(conn, Routes.snake_trait_path(conn, :edit, snake_trait))
      assert html_response(conn, 200) =~ "Edit Snake trait"
    end
  end

  describe "update snake_trait" do
    setup [:create_snake_trait]

    test "redirects when data is valid", %{conn: conn, snake_trait: snake_trait} do
      conn = put(conn, Routes.snake_trait_path(conn, :update, snake_trait), snake_trait: @update_attrs)
      assert redirected_to(conn) == Routes.snake_trait_path(conn, :show, snake_trait)

      conn = get(conn, Routes.snake_trait_path(conn, :show, snake_trait))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, snake_trait: snake_trait} do
      conn = put(conn, Routes.snake_trait_path(conn, :update, snake_trait), snake_trait: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Snake trait"
    end
  end

  describe "delete snake_trait" do
    setup [:create_snake_trait]

    test "deletes chosen snake_trait", %{conn: conn, snake_trait: snake_trait} do
      conn = delete(conn, Routes.snake_trait_path(conn, :delete, snake_trait))
      assert redirected_to(conn) == Routes.snake_trait_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.snake_trait_path(conn, :show, snake_trait))
      end
    end
  end

  defp create_snake_trait(_) do
    snake_trait = snake_trait_fixture()
    %{snake_trait: snake_trait}
  end
end
