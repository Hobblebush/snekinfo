defmodule SnekinfoWeb.ShedController do
  use SnekinfoWeb, :controller

  alias Snekinfo.Sheds
  alias Snekinfo.Sheds.Shed
  alias Snekinfo.Snakes

  def index(conn, params) do
    snake_id = params["snake_id"]
    sheds = if snake_id do
      snake = Snakes.get_snake!(snake_id)
      Sheds.list_sheds(snake_id)
      |> Enum.map(&(%Shed{ &1 | snake: snake }))
    else
      Sheds.list_sheds()
      |> Sheds.preload_snake()
    end
    render(conn, "index.html", sheds: sheds)
  end

  def new(conn, params) do
    snakes = Snakes.list_snakes()
    snake_id = params["snake_id"]
    changeset = Sheds.change_shed(%Shed{snake_id: snake_id})
    render(conn, "new.html", changeset: changeset, snakes: snakes)
  end

  def create(conn, %{"shed" => shed_params}) do
    case Sheds.create_shed(shed_params) do
      {:ok, shed} ->
        conn
        |> put_flash(:info, "Shed created successfully.")
        |> redirect(to: Routes.shed_path(conn, :show, shed))

      {:error, %Ecto.Changeset{} = changeset} ->
        snakes = Snakes.list_snakes()
        render(conn, "new.html", changeset: changeset, snakes: snakes)
    end
  end

  def show(conn, %{"id" => id}) do
    shed = Sheds.get_shed!(id)
    render(conn, "show.html", shed: shed)
  end

  def edit(conn, %{"id" => id}) do
    shed = Sheds.get_shed!(id)
    changeset = Sheds.change_shed(shed)
    snakes = Snakes.list_snakes()
    render(conn, "edit.html", shed: shed, changeset: changeset, snakes: snakes)
  end

  def update(conn, %{"id" => id, "shed" => shed_params}) do
    shed = Sheds.get_shed!(id)

    case Sheds.update_shed(shed, shed_params) do
      {:ok, shed} ->
        conn
        |> put_flash(:info, "Shed updated successfully.")
        |> redirect(to: Routes.shed_path(conn, :show, shed))

      {:error, %Ecto.Changeset{} = changeset} ->
        snakes = Snakes.list_snakes()
        render(conn, "edit.html", shed: shed, changeset: changeset, snakes: snakes)
    end
  end

  def delete(conn, %{"id" => id}) do
    shed = Sheds.get_shed!(id)
    {:ok, _shed} = Sheds.delete_shed(shed)

    conn
    |> put_flash(:info, "Shed deleted successfully.")
    |> redirect(to: Routes.shed_path(conn, :index))
  end
end
