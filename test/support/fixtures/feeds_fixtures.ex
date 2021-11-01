defmodule Snekinfo.FeedsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Snekinfo.Feeds` context.
  """

  alias Snekinfo.SnakesFixtures

  @doc """
  Generate a feed.
  """
  def feed_fixture(attrs \\ %{}) do
    snake = SnakesFixtures.snake_fixture()

    {:ok, feed} =
      attrs
      |> Enum.into(%{
        snake_id: snake.id,
        ingested?: true,
        live?: true,
        date: ~D[2021-10-20],
        weight: 120.5
      })
      |> Snekinfo.Feeds.create_feed()

    feed
  end
end
