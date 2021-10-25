defmodule Snekinfo.FeedsTest do
  use Snekinfo.DataCase

  alias Snekinfo.Feeds

  describe "feeds" do
    alias Snekinfo.Feeds.Feed

    import Snekinfo.FeedsFixtures

    @invalid_attrs %{ingested?: nil, live?: nil, timestamp: nil, weight: nil}

    test "list_feeds/0 returns all feeds" do
      feed = feed_fixture()
      assert Feeds.list_feeds() == [feed]
    end

    test "get_feed!/1 returns the feed with given id" do
      feed = feed_fixture()
      assert Feeds.get_feed!(feed.id) == feed
    end

    test "create_feed/1 with valid data creates a feed" do
      valid_attrs = %{ingested?: true, live?: true, timestamp: ~U[2021-10-20 23:44:00Z], weight: 120.5}

      assert {:ok, %Feed{} = feed} = Feeds.create_feed(valid_attrs)
      assert feed.ingested? == true
      assert feed.live? == true
      assert feed.timestamp == ~U[2021-10-20 23:44:00Z]
      assert feed.weight == 120.5
    end

    test "create_feed/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Feeds.create_feed(@invalid_attrs)
    end

    test "update_feed/2 with valid data updates the feed" do
      feed = feed_fixture()
      update_attrs = %{ingested?: false, live?: false, timestamp: ~U[2021-10-21 23:44:00Z], weight: 456.7}

      assert {:ok, %Feed{} = feed} = Feeds.update_feed(feed, update_attrs)
      assert feed.ingested? == false
      assert feed.live? == false
      assert feed.timestamp == ~U[2021-10-21 23:44:00Z]
      assert feed.weight == 456.7
    end

    test "update_feed/2 with invalid data returns error changeset" do
      feed = feed_fixture()
      assert {:error, %Ecto.Changeset{}} = Feeds.update_feed(feed, @invalid_attrs)
      assert feed == Feeds.get_feed!(feed.id)
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
