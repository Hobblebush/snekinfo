defmodule Snekinfo.Sheds do
  @moduledoc """
  The Sheds context.
  """

  import Ecto.Query, warn: false
  alias Snekinfo.Repo

  alias Snekinfo.Sheds.Shed

  @doc """
  Returns the list of sheds.

  ## Examples

      iex> list_sheds()
      [%Shed{}, ...]

  """
  def list_sheds do
    Repo.all(Shed)
  end

  def list_sheds(snake_id) do
    Repo.all from sh in Shed,
      where: sh.snake_id == ^snake_id
  end

  def list_recent_sheds_for_snake(snake, limit) do
    xs = Repo.all from sh in Shed,
      where: sh.snake_id == ^snake.id,
      limit: ^limit,
      order_by: [desc: sh.date]
    Enum.map(xs, &(%Shed{ &1 | snake: snake }))
  end

  def preload_snake(xx) do
    Repo.preload(xx, :snake)
  end

  @doc """
  Gets a single shed.

  Raises `Ecto.NoResultsError` if the Shed does not exist.

  ## Examples

      iex> get_shed!(123)
      %Shed{}

      iex> get_shed!(456)
      ** (Ecto.NoResultsError)

  """
  def get_shed!(id) do
    Repo.get!(Shed, id)
    |> Repo.preload(:snake)
  end

  @doc """
  Creates a shed.

  ## Examples

      iex> create_shed(%{field: value})
      {:ok, %Shed{}}

      iex> create_shed(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_shed(attrs \\ %{}) do
    %Shed{}
    |> Shed.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a shed.

  ## Examples

      iex> update_shed(shed, %{field: new_value})
      {:ok, %Shed{}}

      iex> update_shed(shed, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_shed(%Shed{} = shed, attrs) do
    shed
    |> Shed.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a shed.

  ## Examples

      iex> delete_shed(shed)
      {:ok, %Shed{}}

      iex> delete_shed(shed)
      {:error, %Ecto.Changeset{}}

  """
  def delete_shed(%Shed{} = shed) do
    Repo.delete(shed)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking shed changes.

  ## Examples

      iex> change_shed(shed)
      %Ecto.Changeset{data: %Shed{}}

  """
  def change_shed(%Shed{} = shed, attrs \\ %{}) do
    Shed.changeset(shed, attrs)
  end
end
