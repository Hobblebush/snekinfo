defmodule Snekinfo.PhotosTest do
  use Snekinfo.DataCase

  alias Snekinfo.Photos

  describe "photos" do
    alias Snekinfo.Photos.Photo

    import Snekinfo.PhotosFixtures
    import Snekinfo.SnakesFixtures

    @invalid_attrs %{caption: nil, filename: nil, order: nil}

    test "list_photos/0 returns all photos" do
      photo = photo_fixture()
      assert Photos.list_photos() == [photo]
    end

    test "get_photo!/1 returns the photo with given id" do
      photo = photo_fixture()
      assert Photos.get_photo!(photo.id) == photo
    end

    test "create_photo/1 with valid data creates a photo" do
      snake = snake_fixture()
      upload = upload_fixture()
      valid_attrs = %{
        snake_id: snake.id,
        caption: "some caption",
        order: 42,
        upload: upload
      }

      assert {:ok, %Photo{} = photo} = Photos.create_photo(valid_attrs)
      assert photo.caption == "some caption"
      assert photo.filename == "sample-photo.jpg"
      assert photo.order == 42
    end

    test "create_photo/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Photos.create_photo(@invalid_attrs)
    end

    test "update_photo/2 with valid data updates the photo" do
      photo = photo_fixture()
      update_attrs = %{caption: "some updated caption", filename: "some updated filename", order: 43}

      assert {:ok, %Photo{} = photo} = Photos.update_photo(photo, update_attrs)
      assert photo.caption == "some updated caption"
      assert photo.filename == "some updated filename"
      assert photo.order == 43
    end

    test "update_photo/2 with invalid data returns error changeset" do
      photo = photo_fixture()
      assert {:error, %Ecto.Changeset{}} = Photos.update_photo(photo, @invalid_attrs)
      assert photo == Photos.get_photo!(photo.id)
    end

    test "delete_photo/1 deletes the photo" do
      photo = photo_fixture()
      assert {:ok, %Photo{}} = Photos.delete_photo(photo)
      assert_raise Ecto.NoResultsError, fn -> Photos.get_photo!(photo.id) end
    end

    test "change_photo/1 returns a photo changeset" do
      photo = photo_fixture()
      assert %Ecto.Changeset{} = Photos.change_photo(photo)
    end
  end
end
