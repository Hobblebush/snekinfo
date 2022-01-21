defmodule Snekinfo.PhotosFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Snekinfo.Photos` context.
  """

  import Snekinfo.SnakesFixtures

  @doc """
  Generate a photo.
  """
  def photo_fixture(attrs \\ %{}) do
    snake = snake_fixture()

    {:ok, photo} =
      attrs
      |> Enum.into(%{
        snake_id: snake.id,
        upload: upload_fixture(),
        caption: "some caption",
        filename: "some filename",
        order: 42
      })
      |> Snekinfo.Photos.create_photo()

    photo
  end

  def upload_fixture() do
    path = Application.app_dir(:snekinfo, "priv/static/images/generic-snake.jpg")
    %Plug.Upload{
      path: path,
      content_type: "image/jpeg",
      filename: "sample-photo.jpg"
    }
  end
end
