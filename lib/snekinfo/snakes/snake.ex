defmodule Snekinfo.Snakes.Snake do
  use Ecto.Schema
  import Ecto.Changeset

  alias Snekinfo.Litters.Litter
  alias Snekinfo.Traits.Trait
  alias Snekinfo.Feeds.Feed
  alias Snekinfo.Weights.Weight

  schema "snakes" do
    field :born, :date
    field :name, :string
    field :sex, :string
    field :produced_by, :string
    field :cost, :decimal
    belongs_to :litter, Litter

    many_to_many :traits, Trait, join_through: "snake_traits", on_replace: :delete
    has_many :feeds, Feed
    has_many :weights, Weight

    timestamps()
  end

  def sexes do
    ["∅", "F", "M"]
  end

  @doc false
  def changeset(snake, attrs) do
    traits = attrs["traits"] || attrs[:traits] || []

    snake
    |> cast(attrs, [:litter_id, :name, :sex, :born, :produced_by, :cost])
    |> put_assoc(:traits, traits)
    |> validate_required([:name, :sex, :born])
    |> validate_inclusion(:sex, sexes())
  end
end
