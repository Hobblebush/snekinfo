defmodule SnekinfoWeb.SnakeController do
  use SnekinfoWeb, :controller

  alias Snekinfo.Snakes
  alias Snekinfo.Snakes.Snake
  alias Snekinfo.Feeds
  alias Snekinfo.Weights

  def index(conn, _params) do
    snakes = Snakes.list_snakes()
    render(conn, "index.html", snakes: snakes)
  end

  def new(conn, _params) do
    changeset = Snakes.change_snake(%Snake{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"snake" => snake_params}) do
    case Snakes.create_snake(snake_params) do
      {:ok, snake} ->
        conn
        |> put_flash(:info, "Snake created successfully.")
        |> redirect(to: Routes.snake_path(conn, :show, snake))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    snake = Snakes.get_snake!(id)
    recent_feeds = Feeds.list_recent_feeds_for_snake(snake, 10)
    recent_weights = Weights.list_recent_weights_for_snake(snake, 10)
    render(conn, "show.html", snake: snake,
      recent_feeds: recent_feeds, recent_weights: recent_weights)
  end

  def edit(conn, %{"id" => id}) do
    snake = Snakes.get_snake!(id)
    changeset = Snakes.change_snake(snake)
    render(conn, "edit.html", snake: snake, changeset: changeset)
  end

  def update(conn, %{"id" => id, "snake" => snake_params}) do
    snake = Snakes.get_snake!(id)

    case Snakes.update_snake(snake, snake_params) do
      {:ok, snake} ->
        conn
        |> put_flash(:info, "Snake updated successfully.")
        |> redirect(to: Routes.snake_path(conn, :show, snake))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", snake: snake, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    snake = Snakes.get_snake!(id)
    {:ok, _snake} = Snakes.delete_snake(snake)

    conn
    |> put_flash(:info, "Snake deleted successfully.")
    |> redirect(to: Routes.snake_path(conn, :index))
  end
end
