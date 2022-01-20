defmodule Snekinfo.Photos do
  @moduledoc """
  The Photos context.
  """

  import Ecto.Query, warn: false
  alias Snekinfo.Repo

  alias Snekinfo.Photos.Photo
  alias Snekinfo.Photos.Upload
  alias Snekinfo.Snakes.Snake

  @doc """
  Returns the list of photos.

  ## Examples

      iex> list_photos()
      [%Photo{}, ...]

  """
  def list_photos do
    Repo.all(Photo)
  end

  def list_photos_for_snake(snake_id) do
    Repo.all from ph in Photo,
      where: ph.snake_id == ^snake_id
  end

  @doc """
  Gets a single photo.

  Raises `Ecto.NoResultsError` if the Photo does not exist.

  ## Examples

      iex> get_photo!(123)
      %Photo{}

      iex> get_photo!(456)
      ** (Ecto.NoResultsError)

  """
  def get_photo!(id), do: Repo.get!(Photo, id)

  def snake_main_photo(%Snake{} = snake) do
    snake_main_photo(snake.id)
  end
  def snake_main_photo(snake_id) do
    Repo.one from ph in Photo,
      where: ph.snake_id == ^snake_id,
      order_by: [ph.order, ph.updated_at],
      limit: 1
  end

  @doc """
  Creates a photo.

  ## Examples

      iex> create_photo(%{field: value})
      {:ok, %Photo{}}

      iex> create_photo(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_photo(attrs \\ %{}) do
    Repo.transaction fn ->
      {:ok, photo} = %Photo{}
      |> Photo.changeset(attrs)
      |> Repo.insert()
      Upload.save_upload!(photo, attrs)
      photo
    end
  end

  @doc """
  Updates a photo.

  ## Examples

      iex> update_photo(photo, %{field: new_value})
      {:ok, %Photo{}}

      iex> update_photo(photo, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_photo(%Photo{} = photo, attrs) do
    Repo.transaction fn ->
      {:ok, photo} = photo
      |> Photo.changeset(attrs)
      |> Repo.update()
      Upload.save_upload!(photo, attrs)
      photo
    end
  end

  @doc """
  Deletes a photo.

  ## Examples

      iex> delete_photo(photo)
      {:ok, %Photo{}}

      iex> delete_photo(photo)
      {:error, %Ecto.Changeset{}}

  """
  def delete_photo(%Photo{} = photo) do
    case Repo.delete(photo) do
      {:ok, ph} ->
        Upload.delete_upload!(photo)
        {:ok, ph}
      other ->
        other
    end
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking photo changes.

  ## Examples

      iex> change_photo(photo)
      %Ecto.Changeset{data: %Photo{}}

  """
  def change_photo(%Photo{} = photo, attrs \\ %{}) do
    Photo.changeset(photo, attrs)
  end
end
