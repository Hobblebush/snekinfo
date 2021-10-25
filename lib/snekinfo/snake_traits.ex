defmodule Snekinfo.Snake_traits do
  @moduledoc """
  The Snake_traits context.
  """

  import Ecto.Query, warn: false
  alias Snekinfo.Repo

  alias Snekinfo.Snake_traits.Snake_trait

  @doc """
  Returns the list of snake_traits.

  ## Examples

      iex> list_snake_traits()
      [%Snake_trait{}, ...]

  """
  def list_snake_traits do
    Repo.all(Snake_trait)
  end

  @doc """
  Gets a single snake_trait.

  Raises `Ecto.NoResultsError` if the Snake trait does not exist.

  ## Examples

      iex> get_snake_trait!(123)
      %Snake_trait{}

      iex> get_snake_trait!(456)
      ** (Ecto.NoResultsError)

  """
  def get_snake_trait!(id), do: Repo.get!(Snake_trait, id)

  @doc """
  Creates a snake_trait.

  ## Examples

      iex> create_snake_trait(%{field: value})
      {:ok, %Snake_trait{}}

      iex> create_snake_trait(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_snake_trait(attrs \\ %{}) do
    %Snake_trait{}
    |> Snake_trait.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a snake_trait.

  ## Examples

      iex> update_snake_trait(snake_trait, %{field: new_value})
      {:ok, %Snake_trait{}}

      iex> update_snake_trait(snake_trait, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_snake_trait(%Snake_trait{} = snake_trait, attrs) do
    snake_trait
    |> Snake_trait.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a snake_trait.

  ## Examples

      iex> delete_snake_trait(snake_trait)
      {:ok, %Snake_trait{}}

      iex> delete_snake_trait(snake_trait)
      {:error, %Ecto.Changeset{}}

  """
  def delete_snake_trait(%Snake_trait{} = snake_trait) do
    Repo.delete(snake_trait)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking snake_trait changes.

  ## Examples

      iex> change_snake_trait(snake_trait)
      %Ecto.Changeset{data: %Snake_trait{}}

  """
  def change_snake_trait(%Snake_trait{} = snake_trait, attrs \\ %{}) do
    Snake_trait.changeset(snake_trait, attrs)
  end
end
