defmodule SnekinfoWeb.PhotoController do
  use SnekinfoWeb, :controller

  alias Snekinfo.Photos
  alias Snekinfo.Photos.Photo
  alias Snekinfo.Photos.Upload
  alias Snekinfo.Snakes

  def index(conn, %{"snake_id" => snake_id}) do
    snake = Snakes.get_snake!(snake_id)
    photos = Photos.list_photos_for_snake(snake_id)
    render(conn, "index.html", snake: snake, photos: photos)
  end

  def new(conn, %{"snake_id" => snake_id}) do
    snake = Snakes.get_snake!(snake_id)
    changeset = Photos.change_photo(%Photo{order: 10})
    render(conn, "new.html", snake: snake, changeset: changeset)
  end

  def create(conn, %{"snake_id" => snake_id, "photo" => photo_params}) do
    snake = Snakes.get_snake!(snake_id)
    photo_params = Map.put(photo_params, "snake_id", snake_id)

    case Photos.create_photo(photo_params) do
      {:ok, photo} ->
        conn
        |> put_flash(:info, "Photo created successfully.")
        |> redirect(to: Routes.photo_path(conn, :show, photo))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", snake: snake, changeset: changeset)
    end
  end

  def raw(conn, %{"id" => id}) do
    photo = Photos.get_photo!(id)
    path = Upload.photo_path(photo)
    conn
    |> put_resp_header("content-type", "image/jpeg")
    |> send_file(200, path)
  end

  def thumb(conn, %{"id" => id}) do
    photo = Photos.get_photo!(id)
    path = Upload.thumb_path(photo)
    conn
    |> put_resp_header("content-type", "image/jpeg")
    |> send_file(200, path)
  end

  def show(conn, %{"id" => id}) do
    photo = Photos.get_photo!(id)
    snake = Snakes.get_snake!(photo.snake_id)
    render(conn, "show.html", snake: snake, photo: photo)
  end

  def edit(conn, %{"id" => id}) do
    photo = Photos.get_photo!(id)
    snake = Snakes.get_snake!(photo.snake_id)
    changeset = Photos.change_photo(photo)
    render(conn, "edit.html", photo: photo, snake: snake, changeset: changeset)
  end

  def update(conn, %{"id" => id, "photo" => photo_params}) do
    photo = Photos.get_photo!(id)
    snake = Snakes.get_snake!(photo.snake_id)

    case Photos.update_photo(photo, photo_params) do
      {:ok, photo} ->
        conn
        |> put_flash(:info, "Photo updated successfully.")
        |> redirect(to: Routes.photo_path(conn, :show, photo))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", photo: photo, snake: snake, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    photo = Photos.get_photo!(id)
    {:ok, _photo} = Photos.delete_photo(photo)

    conn
    |> put_flash(:info, "Photo deleted successfully.")
    |> redirect(to: Routes.snake_photo_path(conn, :index, photo.snake_id))
  end
end
