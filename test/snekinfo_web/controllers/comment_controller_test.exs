defmodule SnekinfoWeb.CommentControllerTest do
  use SnekinfoWeb.ConnCase

  import Snekinfo.SnakesFixtures

  @create_attrs %{ body: "some stuff" }
  @invalid_attrs %{}

  describe "new comment" do
    setup [:log_as_user]

    test "renders form", %{conn: conn} do
      snake = snake_fixture()
      conn = get(conn, Routes.snake_comment_path(conn, :new, snake))
      assert html_response(conn, 200) =~ "New Snake Comment"
    end
  end

  describe "create comment" do
    setup [:log_as_user]

    test "redirects to show when data is valid", %{conn: conn} do
      snake = snake_fixture()

      conn = post(conn, Routes.snake_comment_path(conn, :create, snake),
        comment: @create_attrs)

      assert %{id: _id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.snake_path(conn, :show, snake)

      conn = get(conn, Routes.snake_path(conn, :show, snake))
      assert html_response(conn, 200) =~ "Show Snake"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      snake = snake_fixture()

      conn = post(conn, Routes.snake_comment_path(conn, :create, snake),
        comment: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Snake Comment"
    end
  end
end
