defmodule Snekinfo.Taxa do
  @moduledoc """
  The Taxa context.
  """

  import Ecto.Query, warn: false
  alias Snekinfo.Repo

  alias Snekinfo.Taxa.Species

  @doc """
  Returns the list of species.

  ## Examples

      iex> list_species()
      [%Species{}, ...]

  """
  def list_species do
    Repo.all(Species)
  end

  @doc """
  Gets a single species.

  Raises `Ecto.NoResultsError` if the Species does not exist.

  ## Examples

      iex> get_species!(123)
      %Species{}

      iex> get_species!(456)
      ** (Ecto.NoResultsError)

  """
  def get_species!(id), do: Repo.get!(Species, id)

  @doc """
  Creates a species.

  ## Examples

      iex> create_species(%{field: value})
      {:ok, %Species{}}

      iex> create_species(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_species(attrs \\ %{}) do
    %Species{}
    |> Species.changeset(attrs)
    |> Repo.insert()
  end

  def get_or_create_species(name) do
    if ksb = Repo.get_by(Species, name: name) do
      ksb
    else
      Repo.insert!(%Species{name: name})
    end
  end

  @doc """
  Updates a species.

  ## Examples

      iex> update_species(species, %{field: new_value})
      {:ok, %Species{}}

      iex> update_species(species, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_species(%Species{} = species, attrs) do
    species
    |> Species.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a species.

  ## Examples

      iex> delete_species(species)
      {:ok, %Species{}}

      iex> delete_species(species)
      {:error, %Ecto.Changeset{}}

  """
  def delete_species(%Species{} = species) do
    Repo.delete(species)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking species changes.

  ## Examples

      iex> change_species(species)
      %Ecto.Changeset{data: %Species{}}

  """
  def change_species(%Species{} = species, attrs \\ %{}) do
    Species.changeset(species, attrs)
  end
end
