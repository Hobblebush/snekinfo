defmodule SnekinfoWeb.SnakeControllerTest do
  use SnekinfoWeb.ConnCase

  import Snekinfo.SnakesFixtures

  @create_attrs %{born: ~D[2021-10-20], name: "some name", sex: "some sex"}
  @update_attrs %{born: ~D[2021-10-21], name: "some updated name", sex: "some updated sex"}
  @invalid_attrs %{born: nil, name: nil, sex: nil}

  describe "index" do
    test "lists all snakes", %{conn: conn} do
      conn = get(conn, Routes.snake_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Snakes"
    end
  end

  describe "new snake" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.snake_path(conn, :new))
      assert html_response(conn, 200) =~ "New Snake"
    end
  end

  describe "create snake" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.snake_path(conn, :create), snake: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.snake_path(conn, :show, id)

      conn = get(conn, Routes.snake_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Snake"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.snake_path(conn, :create), snake: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Snake"
    end
  end

  describe "edit snake" do
    setup [:create_snake]

    test "renders form for editing chosen snake", %{conn: conn, snake: snake} do
      conn = get(conn, Routes.snake_path(conn, :edit, snake))
      assert html_response(conn, 200) =~ "Edit Snake"
    end
  end

  describe "update snake" do
    setup [:create_snake]

    test "redirects when data is valid", %{conn: conn, snake: snake} do
      conn = put(conn, Routes.snake_path(conn, :update, snake), snake: @update_attrs)
      assert redirected_to(conn) == Routes.snake_path(conn, :show, snake)

      conn = get(conn, Routes.snake_path(conn, :show, snake))
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, snake: snake} do
      conn = put(conn, Routes.snake_path(conn, :update, snake), snake: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Snake"
    end
  end

  describe "delete snake" do
    setup [:create_snake]

    test "deletes chosen snake", %{conn: conn, snake: snake} do
      conn = delete(conn, Routes.snake_path(conn, :delete, snake))
      assert redirected_to(conn) == Routes.snake_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.snake_path(conn, :show, snake))
      end
    end
  end

  defp create_snake(_) do
    snake = snake_fixture()
    %{snake: snake}
  end
end
