defmodule Snekinfo.FeedsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Snekinfo.Feeds` context.
  """

  @doc """
  Generate a feed.
  """
  def feed_fixture(attrs \\ %{}) do
    {:ok, feed} =
      attrs
      |> Enum.into(%{
        ingested?: true,
        live?: true,
        timestamp: ~U[2021-10-20 23:44:00Z],
        weight: 120.5
      })
      |> Snekinfo.Feeds.create_feed()

    feed
  end
end
