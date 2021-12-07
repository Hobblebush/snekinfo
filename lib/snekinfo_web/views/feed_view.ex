defmodule SnekinfoWeb.FeedView do
  use SnekinfoWeb, :view

  def render("index.json", %{feeds: feeds}) do
    %{data: render_many(feeds, FeedView, "feed.json")}
  end

  def render("show.json", %{feed: feed}) do
    %{data: render_one(feed, FeedView, "feed.json")}
  end

  def render("feed.json", %{feed: feed}) do
    %{
      id: feed.id,
      ingested: feed.ingested?,
      live: feed.live?,
      date: feed.date,
      weight: feed.weight,
      snake: render_assoc(feed.snake, :snake),
      path: Routes.feed_path(SnekinfoWeb.Endpoint, :show, feed),
    }
  end
end
