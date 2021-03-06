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
    xs = Repo.all litter_query()

    Enum.map xs, fn {lit, size} ->
      %Litter{ lit | size: size }
    end
  end

  def list_snake_litters(snake_id) do
    xs = Repo.all from lit in litter_query(),
      where: lit.mother_id == ^snake_id or lit.father_id == ^snake_id

    Enum.map xs, fn {lit, size} ->
      %Litter{ lit | size: size }
    end
  end

  def litter_query do
    from lit in Litter,
      left_join: sn in assoc(lit, :snakes),
      group_by: lit.id,
      select: {lit, count(sn.id)},
      order_by: [desc: :born],
      preload: [:mother, :father]
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
  def get_litter!(id) do
    lit = Repo.get!(Litter, id)
    |> Repo.preload([:mother, :father])
    |> preload_snake_info()

    %Litter{ lit | size: length(lit.snakes), mf_ratio: mf_ratio(lit) }
  end

  def mf_ratio(litter) do
    ms = Enum.filter(litter.snakes, &(&1.sex == "M"))
    fs = Enum.filter(litter.snakes, &(&1.sex == "F"))
    if length(fs) > 0 do
      length(ms)/length(fs)
    else
      nil
    end
  end

  def preload_snake_info(lit) do
    snakes = Snekinfo.Snakes.list_snakes_for_table()
    |> Enum.filter(&(&1.litter_id == lit.id))
    %Litter{ lit | snakes: snakes }
  end

  @doc """
  Creates a litter.

  ## Examples

      iex> create_litter(%{field: value})
      {:ok, %Litter{}}

      iex> create_litter(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_litter(attrs \\ %{}) do
    rv = %Litter{}
    |> Litter.changeset(attrs)
    |> Repo.insert()

    case rv do
      {:ok, litter} ->
        litter = %Litter{ litter | size: 0 }
        {:ok, litter}
      other ->
        other
    end
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
