defmodule Snekinfo.Snakes do
  @moduledoc """
  The Snakes context.
  """

  import Ecto.Query, warn: false
  alias Snekinfo.Repo

  alias Snekinfo.Snakes.Snake

  @doc """
  Returns the list of snakes.

  ## Examples

      iex> list_snakes()
      [%Snake{}, ...]

  """
  def list_snakes do
    Repo.all(Snake)
    |> Repo.preload([:traits, :species, litter: :mother])
  end

  @doc """
  Gets a single snake.

  Raises `Ecto.NoResultsError` if the Snake does not exist.

  ## Examples

      iex> get_snake!(123)
      %Snake{}

      iex> get_snake!(456)
      ** (Ecto.NoResultsError)

  """
  def get_snake!(id) do
    Repo.get!(Snake, id)
    |> Repo.preload([:traits, :species, litter: :mother])
  end

  def get_snake(id) do
    if id do
      get_snake!(id)
    else
      nil
    end
  end

  def list_snake_litters(%Snake{} = snake) do
    list_snake_litters(snake.id)
  end
  def list_snake_litters(snake_id) do
    Snekinfo.Litters.list_snake_litters(snake_id)
  end

  @doc """
  Creates a snake.

  ## Examples

      iex> create_snake(%{field: value})
      {:ok, %Snake{}}

      iex> create_snake(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_snake(attrs \\ %{}) do
    %Snake{}
    |> Snake.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a snake.

  ## Examples

      iex> update_snake(snake, %{field: new_value})
      {:ok, %Snake{}}

      iex> update_snake(snake, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_snake(%Snake{} = snake, attrs) do
    snake
    |> Snake.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a snake.

  ## Examples

      iex> delete_snake(snake)
      {:ok, %Snake{}}

      iex> delete_snake(snake)
      {:error, %Ecto.Changeset{}}

  """
  def delete_snake(%Snake{} = snake) do
    Repo.delete(snake)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking snake changes.

  ## Examples

      iex> change_snake(snake)
      %Ecto.Changeset{data: %Snake{}}

  """
  def change_snake(%Snake{} = snake, attrs \\ %{}) do
    Snake.changeset(snake, attrs)
  end
end
