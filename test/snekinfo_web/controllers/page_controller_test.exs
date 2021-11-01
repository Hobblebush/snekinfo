defmodule SnekinfoWeb.PageControllerTest do
  use SnekinfoWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Snekinfo"
  end
end
