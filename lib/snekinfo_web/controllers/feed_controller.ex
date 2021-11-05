defmodule SnekinfoWeb.FeedController do
  use SnekinfoWeb, :controller

  alias Snekinfo.Feeds
  alias Snekinfo.Feeds.Feed
  alias Snekinfo.Snakes

  def index(conn, params) do
    snake_id = params["snake_id"]
    snake = Snakes.get_snake(snake_id)
    feeds = Feeds.list_feeds(snake_id)
    render(conn, "index.html", feeds: feeds, snake_id: snake_id, snake: snake)
  end

  def new(conn, params) do
    snakes = Snakes.list_snakes()
    snake_id = params["snake_id"]
    changeset = Feeds.change_feed(%Feed{snake_id: snake_id})
    render(conn, "new.html", changeset: changeset, snakes: snakes)
  end

  def create(conn, %{"feed" => feed_params}) do
    case Feeds.create_feed(feed_params) do
      {:ok, feed} ->
        conn
        |> put_flash(:info, "Feed created successfully.")
        |> redirect(to: Routes.feed_path(conn, :show, feed))

      {:error, %Ecto.Changeset{} = changeset} ->
        snakes = Snakes.list_snakes()
        render(conn, "new.html", changeset: changeset, snakes: snakes)
    end
  end

  def show(conn, %{"id" => id}) do
    feed = Feeds.get_feed!(id)
    render(conn, "show.html", feed: feed)
  end

  def edit(conn, %{"id" => id}) do
    snakes = Snakes.list_snakes()
    feed = Feeds.get_feed!(id)
    changeset = Feeds.change_feed(feed)
    render(conn, "edit.html", feed: feed, changeset: changeset, snakes: snakes)
  end

  def update(conn, %{"id" => id, "feed" => feed_params}) do
    feed = Feeds.get_feed!(id)

    case Feeds.update_feed(feed, feed_params) do
      {:ok, feed} ->
        conn
        |> put_flash(:info, "Feed updated successfully.")
        |> redirect(to: Routes.feed_path(conn, :show, feed))

      {:error, %Ecto.Changeset{} = changeset} ->
        snakes = Snakes.list_snakes()
        render(conn, "edit.html", feed: feed, changeset: changeset, snakes: snakes)
    end
  end

  def delete(conn, %{"id" => id}) do
    feed = Feeds.get_feed!(id)
    {:ok, _feed} = Feeds.delete_feed(feed)

    conn
    |> put_flash(:info, "Feed deleted successfully.")
    |> redirect(to: Routes.feed_path(conn, :index))
  end
end
