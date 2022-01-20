defmodule Snekinfo.PhotosFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Snekinfo.Photos` context.
  """

  @doc """
  Generate a photo.
  """
  def photo_fixture(attrs \\ %{}) do
    {:ok, photo} =
      attrs
      |> Enum.into(%{
        caption: "some caption",
        filename: "some filename",
        order: 42
      })
      |> Snekinfo.Photos.create_photo()

    photo
  end
end
