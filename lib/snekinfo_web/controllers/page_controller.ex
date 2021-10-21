defmodule SnekinfoWeb.PageController do
  use SnekinfoWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
