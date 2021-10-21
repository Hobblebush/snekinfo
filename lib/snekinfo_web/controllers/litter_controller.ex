defmodule SnekinfoWeb.LitterController do
  use SnekinfoWeb, :controller

  alias Snekinfo.Litters
  alias Snekinfo.Litters.Litter

  def index(conn, _params) do
    litters = Litters.list_litters()
    render(conn, "index.html", litters: litters)
  end

  def new(conn, _params) do
    changeset = Litters.change_litter(%Litter{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"litter" => litter_params}) do
    case Litters.create_litter(litter_params) do
      {:ok, litter} ->
        conn
        |> put_flash(:info, "Litter created successfully.")
        |> redirect(to: Routes.litter_path(conn, :show, litter))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    litter = Litters.get_litter!(id)
    render(conn, "show.html", litter: litter)
  end

  def edit(conn, %{"id" => id}) do
    litter = Litters.get_litter!(id)
    changeset = Litters.change_litter(litter)
    render(conn, "edit.html", litter: litter, changeset: changeset)
  end

  def update(conn, %{"id" => id, "litter" => litter_params}) do
    litter = Litters.get_litter!(id)

    case Litters.update_litter(litter, litter_params) do
      {:ok, litter} ->
        conn
        |> put_flash(:info, "Litter updated successfully.")
        |> redirect(to: Routes.litter_path(conn, :show, litter))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", litter: litter, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    litter = Litters.get_litter!(id)
    {:ok, _litter} = Litters.delete_litter(litter)

    conn
    |> put_flash(:info, "Litter deleted successfully.")
    |> redirect(to: Routes.litter_path(conn, :index))
  end
end
