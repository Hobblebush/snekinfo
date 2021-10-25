defmodule SnekinfoWeb.Snake_traitController do
  use SnekinfoWeb, :controller

  alias Snekinfo.Snake_traits
  alias Snekinfo.Snake_traits.Snake_trait

  def index(conn, _params) do
    snake_traits = Snake_traits.list_snake_traits()
    render(conn, "index.html", snake_traits: snake_traits)
  end

  def new(conn, _params) do
    changeset = Snake_traits.change_snake_trait(%Snake_trait{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"snake_trait" => snake_trait_params}) do
    case Snake_traits.create_snake_trait(snake_trait_params) do
      {:ok, snake_trait} ->
        conn
        |> put_flash(:info, "Snake trait created successfully.")
        |> redirect(to: Routes.snake_trait_path(conn, :show, snake_trait))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    snake_trait = Snake_traits.get_snake_trait!(id)
    render(conn, "show.html", snake_trait: snake_trait)
  end

  def edit(conn, %{"id" => id}) do
    snake_trait = Snake_traits.get_snake_trait!(id)
    changeset = Snake_traits.change_snake_trait(snake_trait)
    render(conn, "edit.html", snake_trait: snake_trait, changeset: changeset)
  end

  def update(conn, %{"id" => id, "snake_trait" => snake_trait_params}) do
    snake_trait = Snake_traits.get_snake_trait!(id)

    case Snake_traits.update_snake_trait(snake_trait, snake_trait_params) do
      {:ok, snake_trait} ->
        conn
        |> put_flash(:info, "Snake trait updated successfully.")
        |> redirect(to: Routes.snake_trait_path(conn, :show, snake_trait))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", snake_trait: snake_trait, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    snake_trait = Snake_traits.get_snake_trait!(id)
    {:ok, _snake_trait} = Snake_traits.delete_snake_trait(snake_trait)

    conn
    |> put_flash(:info, "Snake trait deleted successfully.")
    |> redirect(to: Routes.snake_trait_path(conn, :index))
  end
end
