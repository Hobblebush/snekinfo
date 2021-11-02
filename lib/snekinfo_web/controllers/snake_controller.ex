defmodule SnekinfoWeb.SnakeController do
  use SnekinfoWeb, :controller

  alias Snekinfo.Snakes
  alias Snekinfo.Snakes.Snake
  alias Snekinfo.Feeds
  alias Snekinfo.Weights
  alias Snekinfo.Litters
  alias Snekinfo.Traits

  def index(conn, _params) do
    snakes = Snakes.list_snakes()
    render(conn, "index.html", snakes: snakes)
  end

  def new(conn, params) do
    litters = Litters.list_litters()
    litter = Enum.find(litters, &(to_string(&1.id) == params["litter_id"]))
    traits = Traits.list_traits()
    snake0 = %Snake{traits: [], litter_id: try_get(litter, [:id]),
                    born: try_get(litter, [:born])}
    changeset = Snakes.change_snake(snake0)
    render(conn, "new.html", changeset: changeset, litters: [nil | litters],
      traits: traits, snake_traits: [])
  end

  def create(conn, %{"snake" => snake_params}) do
    traits = Traits.list_traits()
    snake_params = fill_traits(snake_params, traits)
    case Snakes.create_snake(snake_params) do
      {:ok, snake} ->
        conn
        |> put_flash(:info, "Snake created successfully.")
        |> redirect(to: Routes.snake_path(conn, :show, snake))

      {:error, %Ecto.Changeset{} = changeset} ->
        litters = [nil | Litters.list_litters()]
        render(conn, "new.html", changeset: changeset,
          litters: litters, traits: traits,
          snake_traits: snake_params["traits"])
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
    litters = [nil | Litters.list_litters()]
    traits = Traits.list_traits()
    snake = Snakes.get_snake!(id)
    changeset = Snakes.change_snake(snake)
    render(conn, "edit.html", snake: snake, changeset: changeset,
      litters: litters, traits: traits,
      snake_traits: snake.traits)
  end

  def update(conn, %{"id" => id, "snake" => snake_params}) do
    traits = Traits.list_traits()
    snake_params = fill_traits(snake_params, traits)
    snake = Snakes.get_snake!(id)

    case Snakes.update_snake(snake, snake_params) do
      {:ok, snake} ->
        conn
        |> put_flash(:info, "Snake updated successfully.")
        |> redirect(to: Routes.snake_path(conn, :show, snake))

      {:error, %Ecto.Changeset{} = changeset} ->
        litters = [nil | Litters.list_litters()]
        render(conn, "edit.html", snake: snake, changeset: changeset,
          litters: litters, traits: traits, snake_traits: snake_params["traits"])
    end
  end

  def delete(conn, %{"id" => id}) do
    snake = Snakes.get_snake!(id)
    {:ok, _snake} = Snakes.delete_snake(snake)

    conn
    |> put_flash(:info, "Snake deleted successfully.")
    |> redirect(to: Routes.snake_path(conn, :index))
  end

  def fill_traits(params, traits) do
    xs = (params["traits"] || [])
    |> Enum.map(fn id ->
      Enum.find(traits, &(to_string(&1.id) == id))
    end)
    |> Enum.filter(&(&1 != nil))
    Map.put(params, "traits", xs)
  end
end
