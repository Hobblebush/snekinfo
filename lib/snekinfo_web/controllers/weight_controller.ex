defmodule SnekinfoWeb.WeightController do
  use SnekinfoWeb, :controller

  alias Snekinfo.Weights
  alias Snekinfo.Weights.Weight

  def index(conn, _params) do
    weights = Weights.list_weights()
    render(conn, "index.html", weights: weights)
  end

  def new(conn, _params) do
    changeset = Weights.change_weight(%Weight{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"weight" => weight_params}) do
    case Weights.create_weight(weight_params) do
      {:ok, weight} ->
        conn
        |> put_flash(:info, "Weight created successfully.")
        |> redirect(to: Routes.weight_path(conn, :show, weight))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    weight = Weights.get_weight!(id)
    render(conn, "show.html", weight: weight)
  end

  def edit(conn, %{"id" => id}) do
    weight = Weights.get_weight!(id)
    changeset = Weights.change_weight(weight)
    render(conn, "edit.html", weight: weight, changeset: changeset)
  end

  def update(conn, %{"id" => id, "weight" => weight_params}) do
    weight = Weights.get_weight!(id)

    case Weights.update_weight(weight, weight_params) do
      {:ok, weight} ->
        conn
        |> put_flash(:info, "Weight updated successfully.")
        |> redirect(to: Routes.weight_path(conn, :show, weight))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", weight: weight, changeset: changeset)
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
