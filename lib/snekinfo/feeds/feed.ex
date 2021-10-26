defmodule Snekinfo.Feeds.Feed do
  use Ecto.Schema
  import Ecto.Changeset

  schema "feeds" do
    field :ingested?, :boolean, default: false
    field :live?, :boolean, default: false
    field :timestamp, :utc_datetime
    field :weight, :float
    field :snake_id, :id

    timestamps()
  end

  @doc false
  def changeset(feed, attrs) do
    feed
    |> cast(attrs, [:snake_id, :live?, :weight, :ingested?, :timestamp])
    |> validate_required([:snake_id, :live?, :weight, :ingested?, :timestamp])
  end
end
