defmodule Snekinfo.Litters do
  @moduledoc """
  The Litters context.
  """

  import Ecto.Query, warn: false
  alias Snekinfo.Repo

  alias Snekinfo.Litters.Litter

  @doc """
  Returns the list of litters.

  ## Examples

      iex> list_litters()
      [%Litter{}, ...]

  """
  def list_litters do
    Repo.all(Litter)
  end

  @doc """
  Gets a single litter.

  Raises `Ecto.NoResultsError` if the Litter does not exist.

  ## Examples

      iex> get_litter!(123)
      %Litter{}

      iex> get_litter!(456)
      ** (Ecto.NoResultsError)

  """
  def get_litter!(id), do: Repo.get!(Litter, id)

  @doc """
  Creates a litter.

  ## Examples

      iex> create_litter(%{field: value})
      {:ok, %Litter{}}

      iex> create_litter(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_litter(attrs \\ %{}) do
    %Litter{}
    |> Litter.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a litter.

  ## Examples

      iex> update_litter(litter, %{field: new_value})
      {:ok, %Litter{}}

      iex> update_litter(litter, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_litter(%Litter{} = litter, attrs) do
    litter
    |> Litter.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a litter.

  ## Examples

      iex> delete_litter(litter)
      {:ok, %Litter{}}

      iex> delete_litter(litter)
      {:error, %Ecto.Changeset{}}

  """
  def delete_litter(%Litter{} = litter) do
    Repo.delete(litter)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking litter changes.

  ## Examples

      iex> change_litter(litter)
      %Ecto.Changeset{data: %Litter{}}

  """
  def change_litter(%Litter{} = litter, attrs \\ %{}) do
    Litter.changeset(litter, attrs)
  end
end
