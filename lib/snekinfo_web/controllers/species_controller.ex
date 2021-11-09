defmodule SnekinfoWeb.SpeciesController do
  use SnekinfoWeb, :controller

  alias Snekinfo.Taxa
  alias Snekinfo.Taxa.Species

  def index(conn, _params) do
    species = Taxa.list_species()
    render(conn, "index.html", species: species)
  end

  def new(conn, _params) do
    changeset = Taxa.change_species(%Species{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"species" => species_params}) do
    case Taxa.create_species(species_params) do
      {:ok, species} ->
        conn
        |> put_flash(:info, "Species created successfully.")
        |> redirect(to: Routes.species_path(conn, :show, species))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    species = Taxa.get_species!(id)
    render(conn, "show.html", species: species)
  end

  def edit(conn, %{"id" => id}) do
    species = Taxa.get_species!(id)
    changeset = Taxa.change_species(species)
    render(conn, "edit.html", species: species, changeset: changeset)
  end

  def update(conn, %{"id" => id, "species" => species_params}) do
    species = Taxa.get_species!(id)

    case Taxa.update_species(species, species_params) do
      {:ok, species} ->
        conn
        |> put_flash(:info, "Species updated successfully.")
        |> redirect(to: Routes.species_path(conn, :show, species))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", species: species, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    species = Taxa.get_species!(id)
    {:ok, _species} = Taxa.delete_species(species)

    conn
    |> put_flash(:info, "Species deleted successfully.")
    |> redirect(to: Routes.species_path(conn, :index))
  end
end
