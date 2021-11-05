defmodule Snekinfo.FeedsTest do
  use Snekinfo.DataCase

  alias Snekinfo.Feeds
  alias Snekinfo.SnakesFixtures

  describe "feeds" do
    alias Snekinfo.Feeds.Feed

    import Snekinfo.FeedsFixtures

    @invalid_attrs %{ingested?: false, live?: false, date: "goat", weight: 0.0}

    test "list_feeds/0 returns all feeds" do
      feed = feed_fixture()
      assert_near_eq(Feeds.list_feeds(), [feed])
    end

    test "get_feed!/1 returns the feed with given id" do
      feed = feed_fixture()
      assert_near_eq(Feeds.get_feed!(feed.id), feed)
    end

    test "create_feed/1 with valid data creates a feed" do
      snake = SnakesFixtures.snake_fixture()
      valid_attrs = %{snake_id: snake.id, ingested?: true,
                      live?: true, date: ~D[2021-10-20], weight: 120.5}

      assert {:ok, %Feed{} = feed} = Feeds.create_feed(valid_attrs)
      assert feed.ingested? == true
      assert feed.live? == true
      assert feed.date == ~D[2021-10-20]
      assert feed.weight == 120.5
    end

    test "create_feed/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Feeds.create_feed(@invalid_attrs)
    end

    test "update_feed/2 with valid data updates the feed" do
      feed = feed_fixture()
      update_attrs = %{ingested?: false, live?: false, date: ~D[2021-10-21], weight: 456.7}

      assert {:ok, %Feed{} = feed} = Feeds.update_feed(feed, update_attrs)
      assert feed.ingested? == false
      assert feed.live? == false
      assert feed.date == ~D[2021-10-21]
      assert feed.weight == 456.7
    end

    test "update_feed/2 with invalid data returns error changeset" do
      feed = feed_fixture()
      assert {:error, %Ecto.Changeset{}} = Feeds.update_feed(feed, @invalid_attrs)
      assert_near_eq(feed, Feeds.get_feed!(feed.id))
    end

    test "delete_feed/1 deletes the feed" do
      feed = feed_fixture()
      assert {:ok, %Feed{}} = Feeds.delete_feed(feed)
      assert_raise Ecto.NoResultsError, fn -> Feeds.get_feed!(feed.id) end
    end

    test "change_feed/1 returns a feed changeset" do
      feed = feed_fixture()
      assert %Ecto.Changeset{} = Feeds.change_feed(feed)
    end
  end
end
