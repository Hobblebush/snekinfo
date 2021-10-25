defmodule SnekinfoWeb.TraitController do
  use SnekinfoWeb, :controller

  alias Snekinfo.Traits
  alias Snekinfo.Traits.Trait

  def index(conn, _params) do
    traits = Traits.list_traits()
    render(conn, "index.html", traits: traits)
  end

  def new(conn, _params) do
    changeset = Traits.change_trait(%Trait{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"trait" => trait_params}) do
    case Traits.create_trait(trait_params) do
      {:ok, trait} ->
        conn
        |> put_flash(:info, "Trait created successfully.")
        |> redirect(to: Routes.trait_path(conn, :show, trait))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    trait = Traits.get_trait!(id)
    render(conn, "show.html", trait: trait)
  end

  def edit(conn, %{"id" => id}) do
    trait = Traits.get_trait!(id)
    changeset = Traits.change_trait(trait)
    render(conn, "edit.html", trait: trait, changeset: changeset)
  end

  def update(conn, %{"id" => id, "trait" => trait_params}) do
    trait = Traits.get_trait!(id)

    case Traits.update_trait(trait, trait_params) do
      {:ok, trait} ->
        conn
        |> put_flash(:info, "Trait updated successfully.")
        |> redirect(to: Routes.trait_path(conn, :show, trait))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", trait: trait, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    trait = Traits.get_trait!(id)
    {:ok, _trait} = Traits.delete_trait(trait)

    conn
    |> put_flash(:info, "Trait deleted successfully.")
    |> redirect(to: Routes.trait_path(conn, :index))
  end
end
