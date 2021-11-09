defmodule Snekinfo.Traits.Trait do
  use Ecto.Schema
  import Ecto.Changeset

  alias Snekinfo.Snakes.Snake
  alias Snekinfo.Traits.SnakeTrait
  alias Snekinfo.Taxa.Species

  schema "traits" do
    field :inheritance, :string
    field :name, :string

    belongs_to :species, Species

    many_to_many :snakes, Snake, join_through: "snake_traits"
    has_many :snake_traits, SnakeTrait

    timestamps()
  end

  def inheritances do
    ["∅", "dominant", "recessive", "poly"]
  end

  @doc false
  def changeset(trait, attrs) do
    trait
    |> cast(attrs, [:name, :inheritance, :species_id])
    |> validate_required([:name, :inheritance, :species_id])
    |> validate_inclusion(:inheritance, inheritances())
    |> unique_constraint(:name)
  end

  def delete_changeset(trait) do
    trait
    |> change()
    |> no_assoc_constraint(:snake_traits)
  end
end
