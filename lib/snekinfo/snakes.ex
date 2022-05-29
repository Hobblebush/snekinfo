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
  end

  def list_snakes_for_table do
    list_snakes_for_table(Snake.statuses())
  end

  def list_snakes_for_table(statuses) do
    Repo.all(from sn in Snake,
      inner_join: species in assoc(sn, :species),
      left_join: feeds in assoc(sn, :feeds),
      left_join: weights in assoc(sn, :weights),
      left_join: litter in assoc(sn, :litter),
      left_join: mother in assoc(litter, :mother),
      order_by: {:asc, :name},
      where: sn.status in ^statuses,
      preload: [feeds: feeds, weights: weights, species: species,
                litter: {litter, [mother: mother]}]
    )
    |> Repo.preload([:traits])
    |> Enum.map(&take_latest_data/1)
    |> Enum.map(&drop_uneaten_feeds/1)
  end

  def take_latest_data(snake) do
    fs = Enum.sort_by(snake.feeds, &(&1.date), {:desc, Date})
    ws = Enum.sort_by(snake.weights, &(&1.date), {:desc, Date})
    %Snake{ snake | feeds: fs, weights: ws }
  end

  def drop_uneaten_feeds(snake) do
    fs = Enum.filter snake.feeds, fn feed ->
      feed.ingested?
    end
    %Snake{ snake | feeds: fs }
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

  def get_snake_by_name!(name) do
    Repo.get_by!(Snake, name: name)
    |> Repo.preload([:traits, :species])
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
