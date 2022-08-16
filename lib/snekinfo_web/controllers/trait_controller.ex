defmodule SnekinfoWeb.TraitController do
  use SnekinfoWeb, :controller

  alias SnekinfoWeb.TraitView

  alias Snekinfo.Traits
  alias Snekinfo.Traits.Trait
  alias Snekinfo.Taxa

  def index(conn, _params) do
    traits = Traits.list_traits()
    |> TraitView.sort_traits()
    render(conn, "index.html", traits: traits)
  end

  def new(conn, _params) do
    species = Taxa.list_species()
    changeset = Traits.change_trait(%Trait{})
    render(conn, "new.html", changeset: changeset, species: species)
  end

  def create(conn, %{"trait" => trait_params}) do
    case Traits.create_trait(trait_params) do
      {:ok, trait} ->
        conn
        |> put_flash(:info, "Trait created successfully.")
        |> redirect(to: Routes.trait_path(conn, :show, trait))

      {:error, %Ecto.Changeset{} = changeset} ->
        species = Taxa.list_species()
        render(conn, "new.html", changeset: changeset, species: species)
    end
  end

  def show(conn, %{"id" => id}) do
    trait = Traits.get_trait!(id)
    |> Traits.preload_trait_snakes()

    render(conn, "show.html", trait: trait)
  end

  def edit(conn, %{"id" => id}) do
    trait = Traits.get_trait!(id)
    species = Taxa.list_species()
    changeset = Traits.change_trait(trait)
    render(conn, "edit.html", trait: trait, changeset: changeset, species: species)
  end

  def update(conn, %{"id" => id, "trait" => trait_params}) do
    trait = Traits.get_trait!(id)

    case Traits.update_trait(trait, trait_params) do
      {:ok, trait} ->
        conn
        |> put_flash(:info, "Trait updated successfully.")
        |> redirect(to: Routes.trait_path(conn, :show, trait))

      {:error, %Ecto.Changeset{} = changeset} ->
        species = Taxa.list_species()
        render(conn, "edit.html", trait: trait, changeset: changeset, species: species)
    end
  end

  def delete(conn, %{"id" => id}) do
    trait = Traits.get_trait!(id)
    case Traits.delete_trait(trait) do
      {:ok, _trait} ->
        conn
        |> put_flash(:info, "Trait deleted successfully.")
        |> redirect(to: Routes.trait_path(conn, :index))
      {:error, cset} ->
        conn
        |> put_flash(:error, inspect(cset.errors))
        |> redirect(to: Routes.trait_path(conn, :show, trait))
    end
  end
end
