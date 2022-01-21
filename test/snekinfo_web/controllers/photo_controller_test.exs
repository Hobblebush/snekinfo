defmodule SnekinfoWeb.PhotoControllerTest do
  use SnekinfoWeb.ConnCase

  import Snekinfo.PhotosFixtures
  import Snekinfo.SnakesFixtures

  @create_attrs %{caption: "some caption", filename: "some filename", order: 42}
  @update_attrs %{caption: "some updated caption", filename: "some updated filename", order: 43}
  @invalid_attrs %{caption: nil, filename: nil, order: nil}

  describe "index" do
    test "lists all photos", %{conn: conn} do
      snake = snake_fixture()

      conn = get(conn, Routes.snake_photo_path(conn, :index, snake.id))
      assert html_response(conn, 200) =~ "Photos for #{snake.name}"
    end
  end

  describe "new photo" do
    test "renders form", %{conn: conn} do
      snake = snake_fixture()

      conn = get(conn, Routes.snake_photo_path(conn, :new, snake.id))
      assert html_response(conn, 200) =~ "New Photo"
    end
  end

  describe "create photo" do
    test "redirects to show when data is valid", %{conn: conn} do
      snake = snake_fixture()

      conn = post(conn, Routes.snake_photo_path(conn, :create, snake.id),
        photo: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.photo_path(conn, :show, id)

      conn = get(conn, Routes.photo_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Photo"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      snake = snake_fixture()
      attrs = Map.put(@invalid_attrs, "upload", upload_fixture())

      conn = post(conn, Routes.snake_photo_path(conn, :create, snake.id),
        photo: attrs)
      assert html_response(conn, 200) =~ "New Photo"
    end
  end

  describe "edit photo" do
    setup [:create_photo]

    test "renders form for editing chosen photo", %{conn: conn, photo: photo} do
      conn = get(conn, Routes.photo_path(conn, :edit, photo))
      assert html_response(conn, 200) =~ "Edit Photo"
    end
  end

  describe "update photo" do
    setup [:create_photo]

    test "redirects when data is valid", %{conn: conn, photo: photo} do
      conn = put(conn, Routes.photo_path(conn, :update, photo), photo: @update_attrs)
      assert redirected_to(conn) == Routes.photo_path(conn, :show, photo)

      conn = get(conn, Routes.photo_path(conn, :show, photo))
      assert html_response(conn, 200) =~ "some updated caption"
    end

    test "renders errors when data is invalid", %{conn: conn, photo: photo} do
      conn = put(conn, Routes.photo_path(conn, :update, photo), photo: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Photo"
    end
  end

  describe "delete photo" do
    setup [:create_photo]

    test "deletes chosen photo", %{conn: conn, photo: photo} do
      conn = delete(conn, Routes.photo_path(conn, :delete, photo))
      assert redirected_to(conn) == Routes.snake_photo_path(conn, :index, photo.snake_id)

      assert_error_sent 404, fn ->
        get(conn, Routes.photo_path(conn, :show, photo))
      end
    end
  end

  defp create_photo(_) do
    photo = photo_fixture()
    %{photo: photo}
  end
end
