defmodule Snekinfo.Snakes.Snake do
  use Ecto.Schema
  import Ecto.Changeset

  alias Snekinfo.Litters.Litter
  alias Snekinfo.Traits.Trait
  alias Snekinfo.Feeds.Feed
  alias Snekinfo.Weights.Weight
  alias Snekinfo.Taxa.Species

  schema "snakes" do
    field :born, :date
    field :name, :string
    field :sex, :string
    field :produced_by, :string
    field :cost, :decimal
    field :status, :string
    field :price, :decimal
    field :notes, :string

    belongs_to :litter, Litter
    belongs_to :species, Species

    has_many :feeds, Feed
    has_many :weights, Weight

    many_to_many :traits, Trait, join_through: "snake_traits", on_replace: :delete

    timestamps()
  end

  def sexes do
    ["∅", "F", "M"]
  end

  def statuses do
    ["keep", "sell", "dead", "gone"]
  end

  def active_statuses do
    ["keep", "sell"]
  end

  def active_status?(status) do
    status in active_statuses()
  end

  @doc false
  def changeset(snake, attrs) do
    traits = attrs["traits"] || attrs[:traits] || []

    snake
    |> cast(attrs, [
          :litter_id, :name, :sex, :born, :produced_by, :cost, :species_id,
          :status, :price, :notes
        ])
    |> validate_trait_species(traits)
    |> put_assoc(:traits, traits)
    |> validate_required([:name, :sex, :born])
    |> validate_inclusion(:sex, sexes())
    |> validate_inclusion(:status, statuses())
    |> unique_constraint(:name)
  end

  def validate_trait_species(cset, traits) do
    species_id = get_field(cset, :species_id)
    if Enum.all?(traits, &(&1.species_id == species_id)) do
      cset
    else
      add_error(cset, :traits, "Not all traits have correct species")
    end
  end
end
