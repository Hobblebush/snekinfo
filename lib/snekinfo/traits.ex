defmodule Snekinfo.Traits do
  @moduledoc """
  The Traits context.
  """

  import Ecto.Query, warn: false
  alias Snekinfo.Repo

  alias Snekinfo.Traits.Trait

  @doc """
  Returns the list of traits.

  ## Examples

      iex> list_traits()
      [%Trait{}, ...]

  """
  def list_traits do
    Repo.all from tr in Trait,
      order_by: :name,
      preload: [:species]
  end

  @doc """
  Gets a single trait.

  Raises `Ecto.NoResultsError` if the Trait does not exist.

  ## Examples

      iex> get_trait!(123)
      %Trait{}

      iex> get_trait!(456)
      ** (Ecto.NoResultsError)

  """
  def get_trait!(id), do: Repo.get!(Trait, id)

  def preload_trait_snakes(trait) do
    trait
    |> Repo.preload([
      :species,
      snakes: [:litter, :traits, :species, :weights, :feeds]]
    )
  end

  @doc """
  Creates a trait.

  ## Examples

      iex> create_trait(%{field: value})
      {:ok, %Trait{}}

      iex> create_trait(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_trait(attrs \\ %{}) do
    %Trait{}
    |> Trait.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a trait.

  ## Examples

      iex> update_trait(trait, %{field: new_value})
      {:ok, %Trait{}}

      iex> update_trait(trait, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_trait(%Trait{} = trait, attrs) do
    trait
    |> Trait.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a trait.

  ## Examples

      iex> delete_trait(trait)
      {:ok, %Trait{}}

      iex> delete_trait(trait)
      {:error, %Ecto.Changeset{}}

  """
  def delete_trait(%Trait{} = trait) do
    trait
    |> Trait.delete_changeset()
    |> Repo.delete()
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking trait changes.

  ## Examples

      iex> change_trait(trait)
      %Ecto.Changeset{data: %Trait{}}

  """
  def change_trait(%Trait{} = trait, attrs \\ %{}) do
    Trait.changeset(trait, attrs)
  end
end
