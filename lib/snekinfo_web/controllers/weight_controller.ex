defmodule SnekinfoWeb.WeightController do
  use SnekinfoWeb, :controller

  alias Snekinfo.Weights
  alias Snekinfo.Weights.Weight
  alias Snekinfo.Snakes

  def index(conn, params) do
    snake_id = params["snake_id"]
    snake = Snakes.get_snake(snake_id)
    weights = Weights.list_weights(snake_id)
    render(conn, "index.html", weights: weights, snake_id: snake_id, snake: snake)
  end

  def new(conn, params) do
    snakes = Snakes.list_snakes()
    snake_id = params["snake_id"]
    changeset = Weights.change_weight(%Weight{snake_id: snake_id})
    render(conn, "new.html", changeset: changeset, snakes: snakes)
  end

  def create(conn, %{"weight" => weight_params}) do
    case Weights.create_weight(weight_params) do
      {:ok, weight} ->
        conn
        |> put_flash(:info, "Weight created successfully.")
        |> redirect(to: Routes.weight_path(conn, :show, weight))

      {:error, %Ecto.Changeset{} = changeset} ->
        snakes = Snakes.list_snakes()
        render(conn, "new.html", changeset: changeset, snakes: snakes)
    end
  end

  def show(conn, %{"id" => id}) do
    weight = Weights.get_weight!(id)
    render(conn, "show.html", weight: weight)
  end

  def edit(conn, %{"id" => id}) do
    snakes = Snakes.list_snakes()
    weight = Weights.get_weight!(id)
    changeset = Weights.change_weight(weight)
    render(conn, "edit.html", weight: weight, changeset: changeset,
      snakes: snakes)
  end

  def update(conn, %{"id" => id, "weight" => weight_params}) do
    weight = Weights.get_weight!(id)

    case Weights.update_weight(weight, weight_params) do
      {:ok, weight} ->
        conn
        |> put_flash(:info, "Weight updated successfully.")
        |> redirect(to: Routes.weight_path(conn, :show, weight))

      {:error, %Ecto.Changeset{} = changeset} ->
        snakes = Snakes.list_snakes()
        render(conn, "edit.html", weight: weight, changeset: changeset, snakes: snakes)
    end
  end

  def delete(conn, %{"id" => id}) do
    weight = Weights.get_weight!(id)
    {:ok, _weight} = Weights.delete_weight(weight)

    conn
    |> put_flash(:info, "Weight deleted successfully.")
    |> redirect(to: Routes.weight_path(conn, :index))
  end
end
