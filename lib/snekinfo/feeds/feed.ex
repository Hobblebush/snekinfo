defmodule Snekinfo.Feeds.Feed do
  use Ecto.Schema
  import Ecto.Changeset

  alias Snekinfo.Snakes.Snake

  schema "feeds" do
    field :ingested?, :boolean, default: false
    field :live?, :boolean, default: false
    field :date, :date
    field :weight, :float
    belongs_to :snake, Snake

    timestamps()
  end

  @doc false
  def changeset(feed, attrs) do
    feed
    |> cast(attrs, [:snake_id, :live?, :weight, :ingested?, :date])
    |> validate_required([:snake_id, :live?, :weight, :ingested?, :date])
  end
end
