defmodule Snekinfo.Weights do
  @moduledoc """
  The Weights context.
  """

  import Ecto.Query, warn: false
  alias Snekinfo.Repo

  alias Snekinfo.Weights.Weight

  @doc """
  Returns the list of weights.

  ## Examples

      iex> list_weights()
      [%Weight{}, ...]

  """
  def list_weights do
    Repo.all(Weight)
    |> Repo.preload(:snake)
  end

  def list_weights(snake_id) do
    if snake_id do
      Repo.all from wt in Weight,
        where: wt.snake_id == ^snake_id
    else
      list_weights()
    end
  end

  def list_recent_weights_for_snake(snake, limit) do
    xs = Repo.all from wt in Weight,
      where: wt.snake_id == ^snake.id,
      limit: ^limit,
      order_by: [desc: wt.date]
    Enum.map(xs, &(%Weight{ &1 | snake: snake }))
  end

  @doc """
  Gets a single weight.

  Raises `Ecto.NoResultsError` if the Weight does not exist.

  ## Examples

      iex> get_weight!(123)
      %Weight{}

      iex> get_weight!(456)
      ** (Ecto.NoResultsError)

  """
  def get_weight!(id) do
    Repo.get!(Weight, id)
    |> Repo.preload(:snake)
  end

  @doc """
  Creates a weight.

  ## Examples

      iex> create_weight(%{field: value})
      {:ok, %Weight{}}

      iex> create_weight(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_weight(attrs \\ %{}) do
    %Weight{}
    |> Weight.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a weight.

  ## Examples

      iex> update_weight(weight, %{field: new_value})
      {:ok, %Weight{}}

      iex> update_weight(weight, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_weight(%Weight{} = weight, attrs) do
    weight
    |> Weight.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a weight.

  ## Examples

      iex> delete_weight(weight)
      {:ok, %Weight{}}

      iex> delete_weight(weight)
      {:error, %Ecto.Changeset{}}

  """
  def delete_weight(%Weight{} = weight) do
    Repo.delete(weight)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking weight changes.

  ## Examples

      iex> change_weight(weight)
      %Ecto.Changeset{data: %Weight{}}

  """
  def change_weight(%Weight{} = weight, attrs \\ %{}) do
    Weight.changeset(weight, attrs)
  end
end
